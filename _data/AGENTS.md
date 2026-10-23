# _data/

- `books.yml`: affiliate-link rules are in `my-reading-list/AGENTS.md`.
- `themes.yml`: theme rules are in `css/AGENTS.md`.
- `heatmaps.json`: the Garmin heatmaps `pages.yml` renders into `_includes/garmin/<name>.svg`
  (config format: https://github.com/EdSancha/garmin-heatmap#as-static-svg). Only grids without
  `"enabled": false` are fetched and rendered, so sleep and HRV data never leave Garmin while
  their grids are off. Enabling one fetches its data from the next deploy on; it is public once a
  page includes the SVG.
  `pages.yml` also publishes `<name>-light.svg` and `<name>-dark.svg` (fixed colours) at
  `/assets/garmin/` for the GitHub profile README (EdSancha/Edsancha); renaming or disabling a
  grid breaks its image there.
