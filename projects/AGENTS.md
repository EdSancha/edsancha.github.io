# projects/

The Projects section: `projects/index.html` lists every file in `_projects/` (a Jekyll collection,
`/projects/:name/`), newest `date` first, rendered with `_layouts/project.html`.

- **A project** is `_projects/<slug>.markdown` with front matter `title`, `date`, `description`
  (the summary: one plain sentence, shown on the index and in meta tags, like a post's), and
  optionally `image` (a sample image under `img/projects/`, also the social preview), `image_alt`
  (required with `image`), `image_caption` (a short note shown under the image on the index, e.g.
  to say it is sample data) and `repo` (shown as "Code:" under the summary). No `layout` needed.
- **Garmin heatmaps** go in with `{% include helpers/garmin-heatmap.html name="<grid>" %}`, where
  `<grid>` is a `name` in `_data/heatmaps.json`. The SVG exists only in deploy builds; elsewhere a
  note shows instead. Colours come from the `--heatmap-*` tokens in `css/main.css`.
