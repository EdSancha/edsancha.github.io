# edsancha.com

Personal site of Eduardo Diaz Sancha: home page, Work history, Writing (blog) and Reading List.
Plain Jekyll, no theme, no JavaScript framework. Hosted on GitHub Pages.

## How it is built and deployed

- GitHub Pages builds the `master` branch with the `github-pages` gem. **Every push to `master` goes live** at https://edsancha.com. Work on a branch and open a PR.
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
| `_includes/` | `header.html` (head via `{% seo %}`, nav, progress bar), `footer.html` (social links), `helpers/strava.html` |
| `css/main.css` | All styling. Uses CSS custom properties; light and dark via `prefers-color-scheme` |
| `img/` | Images. `img/apps/` are the Work page tiles, `img/social-icons/` the footer icons |
| `feed.xml` | RSS, last 10 posts |
| `assets/` | Downloadable files. `eduardo-diaz-sancha-resume.pdf` is linked from Home and Work; replace it in place to update the resume, keep the file name |

## Conventions

- **Posts**: follow `.claude/skills/new-post/SKILL.md` (file name, front matter, reading time, republished-article fields). `description` is used in the index, RSS and meta tags, so keep it one plain sentence with no "From Substack:" style prefix.
- **Metadata**: title, description, canonical, Open Graph, Twitter card and JSON-LD come from `jekyll-seo-tag` reading front matter (`title`, `description`, `image`, `canonical_url`). Page titles are short ("Work", "Writing"); the plugin appends the site name. `sitemap.xml` and `robots.txt` are generated; set `sitemap: false` in front matter to keep a file out.
- **Links**: outbound links to companies and products use `rel="external nofollow"` and `target="_blank"`. Use `https://`. Internal links are root-relative (`/feed.xml`, not `../feed.xml`) so they work on paginated pages.
- **Styling**: add rules to `css/main.css` using the existing custom properties (`--body-foreground`, `--link-foreground`, ...). Any new color must work in both light and dark mode. No CSS frameworks, no build step.
- **Affiliate links**: book links are generated from the ASIN in `_data/books.yml` as `https://www.amazon.com/dp/<asin>?tag=eds02a-20` with `rel="external nofollow sponsored"`; the disclosure lives at `/disclosure/` and is linked from the footer. Keep it that way.
- **HTML**: 2-space indentation (`.editorconfig`). Keep the site dependency-free: no npm, no bundlers.

## Guardrails for agents

- Biographical content (home intro, Work history, Reading List opinions, post bodies) is the owner's voice. Fix typos and broken links freely; do not change facts, dates, titles or opinions unless the task asks for it.
- Do not add, remove or rename pages without being asked; URLs are linked from elsewhere.
- Do not commit `_site/`, `.jekyll-cache/`, `vendor/`, or OS files (`.DS_Store`, `Thumbs.db`).
- Before finishing any change: `make check` passes, and pages you touched look right in light and dark mode.
