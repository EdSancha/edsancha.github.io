# edsancha.com

Personal site of Eduardo Diaz Sancha: home page, Work history, Writing (blog) and Reading List.
Plain Jekyll, no theme, no JavaScript framework. Hosted on GitHub Pages.

## How it is built and deployed

- `.github/workflows/pages.yml` builds and deploys the site: production comes from `master` and lands at the root of https://edsancha.com. **Every push to `master` goes live.** Work on a branch and open a PR. (Pages source is set to "GitHub Actions", not "branch".)
- The same deployment publishes one unlisted preview per `theme/*` branch at `/preview/<name>/`, listed at `/preview/`. This is for reviewing a theme still in development, on the real site, before it is merged; finished themes need no branch, because the nav picker already offers them. Previews are built with `_config.preview.yml` overlaid, so they are `noindex`, carry no analytics, show a preview bar and stay out of the sitemap. Push a `theme/*` branch to get a preview; delete the branch to remove it. A theme branch that fails to build is skipped and never blocks a production deploy.
- The `Gemfile` pins `github-pages`, so a local build matches production. Only plugins on the GitHub Pages allowlist work (`jekyll-paginate` and `jekyll-gist` are in use).
- `CNAME`, `url`, `baseurl` and the Google Analytics tag in `_includes/header.html` are production settings. Do not change them unless asked.

## Commands

```sh
make install   # bundle install (first time)
make build     # bundle exec jekyll build --strict_front_matter
make serve     # local preview at http://localhost:4000 with live reload
make check     # build + htmlproofer on _site (internal links, images, alt text)
```

CI (`.github/workflows/ci.yml`) runs `make check` on every PR and push to `master`. Run it locally before pushing.

## Layout of the repo

| Path | What it is |
|---|---|
| `index.markdown` | Home page: intro, Now section, recent writing |
| `work/index.html` | Work history, recognition, app grid (rendered from `_data/apps.yml`) |
| `blog/index.html` | Writing index (paginated, 5 per page, `/blog/:num`) |
| `blog/_posts/` | Posts, `YYYY-MM-DD-slug.markdown` |
| `blog/categories/index.html` | All posts grouped by category; post and index category links point at its anchors |
| `my-reading-list/index.markdown` | Reading List page: intro prose plus a loop over `_data/books.yml` |
| `_data/books.yml` | The books, in page order: sections (`title`, `level`, optional `intro`) with `books` (`title`, `asin`, optional `note`). Add a book here, not in the page |
| `_data/apps.yml` | The Work page app tiles (`name`, `url`, `image`, optional `alt`/`title`). Add an app here, not in the page |
| `disclosure/index.markdown` | Affiliate-link disclosure |
| `_layouts/` | `default` (chrome), `post` (all articles; `intro: <name>` in front matter pulls in `_includes/intro-<name>.html`, used by the weekly reading roundups) |
| `_includes/` | `header.html` (head via `{% seo %}`, nav, progress bar), `theme-switcher.html` (the nav's theme picker), `footer.html` (social links), `helpers/strava.html` |
| `css/main.css` | All styling, plus the design tokens every theme overrides. Light and dark via `prefers-color-scheme` |
| `css/themes/` | One file per theme, overriding tokens only. `legacy.css` overrides nothing: the values in `main.css` are that theme, and it carries only the Poppins import |
| `_data/themes.yml` | The themes the nav picker offers, and the face each name is set in. A new theme needs an entry here as well as a file in `css/themes/` |
| `css/theme-fonts.css` | The label faces the picker's list needs but the page has not loaded. Fetched by the picker on first open, never on page load |
| `img/` | Images. `img/apps/` are the Work page tiles, `img/social-icons/` the footer icons |
| `feed.xml` | RSS, last 10 posts |
| `_config.preview.yml` | Overlay applied to theme previews only (noindex, no analytics, no sitemap) |
| `.github/workflows/pages.yml` | Builds production plus every `theme/*` preview and deploys them together |
| `.github/scripts/build-previews.sh` | Builds each `theme/*` branch into `_site/preview/<name>/` |
| `assets/` | Downloadable files. `eduardo-diaz-sancha-resume.pdf` is linked from Home and Work; replace it in place to update the resume, keep the file name |

## Conventions

- **Posts**: follow `.claude/skills/new-post/SKILL.md` (file name, front matter, reading time, republished-article fields). `description` is used in the index, RSS and meta tags, so keep it one plain sentence with no "From Substack:" style prefix.
- **Metadata**: title, description, canonical, Open Graph, Twitter card and JSON-LD come from `jekyll-seo-tag` reading front matter (`title`, `description`, `image`, `canonical_url`). Page titles are short ("Work", "Writing"); the plugin appends the site name. `sitemap.xml` and `robots.txt` are generated; set `sitemap: false` in front matter to keep a file out.
- **Links**: outbound links to companies and products use `rel="external nofollow"` and `target="_blank"`. Use `https://`. Every internal link and asset path must go through `relative_url` (`{{ '/feed.xml' | relative_url }}`, `{{ post.url | relative_url }}`) — never a bare `/path`, which would break the preview builds that run under a `/preview/<name>/` baseurl.
- **Styling**: add rules to `css/main.css` using the design tokens at the top of that file (`--body-foreground`, `--link-foreground`, `--muted-foreground`, `--meta-font-family`, ...). Never hard-code a colour, font or measure in a rule: put a token on `:root` and use it, or a theme cannot change it. Any new value must work in both light and dark mode. No CSS frameworks, no build step.
- **Themes**: `site_theme` in `_config.yml` picks a file from `css/themes/`, loaded after `main.css`. It is what a first-time visitor sees; the nav's theme picker lets them choose another, stored under the `theme` key in `localStorage` and applied before first paint. A theme overrides tokens only, never structure, and must define **both** its light values on `:root` and its dark values in its own `prefers-color-scheme: dark` block — `main.css` has a dark block earlier in source order, so a light-only theme would leak into dark mode. Adding a theme means two edits: the file in `css/themes/`, and an entry in `_data/themes.yml` (`name`, `label`, the `font` its label is set in, and the `google` family to load for it) so the picker lists it. A theme's own webfont belongs in its own file, so pages on other themes do not fetch it.
- **Affiliate links**: book links are generated from the ASIN in `_data/books.yml` as `https://www.amazon.com/dp/<asin>?tag=eds02a-20` with `rel="external nofollow sponsored"`; the disclosure lives at `/disclosure/` and is linked from the footer. Keep it that way.
- **HTML**: 2-space indentation (`.editorconfig`). Keep the site dependency-free: no npm, no bundlers.

## Guardrails for agents

- Biographical content (home intro, Work history, Reading List opinions, post bodies) is the owner's voice. Fix typos and broken links freely; do not change facts, dates, titles or opinions unless the task asks for it.
- Do not add, remove or rename pages without being asked; URLs are linked from elsewhere.
- Do not commit `_site/`, `.jekyll-cache/`, `vendor/`, or OS files (`.DS_Store`, `Thumbs.db`).
- Before finishing any change: `make check` passes, and pages you touched look right in light and dark mode.
