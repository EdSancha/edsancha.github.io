#!/usr/bin/env bash
#
# Build every theme/* branch into _site/preview/<name>/ and write an index
# listing what was built.
#
# Run from the root of a checkout of the production branch, after the
# production site has been built into _site. Each preview is built from its own
# branch but with this branch's _config.preview.yml overlaid, so the noindex /
# no-analytics rules are controlled centrally and a theme branch cannot opt out.
#
# A branch that fails to build is skipped and reported; it never fails the run,
# so a broken theme branch cannot block a production deploy.

set -uo pipefail

MASTER_DIR="$PWD"
PREVIEW_ROOT="$MASTER_DIR/_site/preview"
PREVIEW_CONFIG="$MASTER_DIR/_config.preview.yml"

if [ ! -f "$PREVIEW_CONFIG" ]; then
  echo "No _config.preview.yml; skipping previews." >&2
  exit 0
fi

branches=$(git for-each-ref --format='%(refname:lstrip=3)' 'refs/remotes/origin/theme/' || true)

if [ -z "$branches" ]; then
  echo "No theme/* branches; nothing to preview."
  exit 0
fi

built=()
skipped=()

for branch in $branches; do
  # theme/foo -> foo ; theme/foo/bar -> foo-bar
  name=${branch#theme/}
  name=${name//\//-}

  echo "::group::preview: $branch -> /preview/$name/"
  worktree=$(mktemp -d)

  if ! git worktree add --detach --quiet "$worktree" "origin/$branch"; then
    echo "could not check out origin/$branch" >&2
    skipped+=("$branch (checkout failed)")
    rm -rf "$worktree"
    echo "::endgroup::"
    continue
  fi

  if bundle exec jekyll build \
        --source "$worktree" \
        --destination "$PREVIEW_ROOT/$name" \
        --baseurl "/preview/$name" \
        --config "$worktree/_config.yml,$PREVIEW_CONFIG" \
        --strict_front_matter; then
    built+=("$name|$branch")
    echo "built /preview/$name/"
  else
    echo "build failed for $branch" >&2
    skipped+=("$branch (build failed)")
    rm -rf "${PREVIEW_ROOT:?}/$name"
  fi

  git worktree remove --force "$worktree" >/dev/null 2>&1 || rm -rf "$worktree"
  echo "::endgroup::"
done

if [ ${#skipped[@]} -gt 0 ]; then
  echo "Skipped previews:"
  printf '  - %s\n' "${skipped[@]}"
fi

if [ ${#built[@]} -eq 0 ]; then
  echo "No previews built."
  exit 0
fi

# Landing page listing the previews that built.
mkdir -p "$PREVIEW_ROOT"
{
  cat <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex, nofollow">
<title>Previews</title>
<style>
  :root { color-scheme: light dark; }
  body { margin: 0 auto; padding: 2em 1em; max-width: 34em;
         font: 16px/1.5 system-ui, -apple-system, "Segoe UI", Roboto, sans-serif; }
  h1 { font-size: 1.5em; margin: 0 0 0.2em; }
  p { color: #767676; margin: 0 0 2em; }
  ul { list-style: none; padding: 0; }
  li { margin-bottom: 0.8em; }
  a { font-weight: 600; }
  code { color: #767676; font-weight: normal; font-size: 0.85em; }
</style>
</head>
<body>
<h1>Previews</h1>
<p>Unlisted builds of theme branches. Not indexed, no analytics.</p>
<ul>
HTML
  for entry in "${built[@]}"; do
    printf '<li><a href="./%s/">%s</a> <code>%s</code></li>\n' \
      "${entry%%|*}" "${entry%%|*}" "${entry##*|}"
  done
  cat <<'HTML'
</ul>
</body>
</html>
HTML
} > "$PREVIEW_ROOT/index.html"

echo "Built ${#built[@]} preview(s); index at /preview/."
