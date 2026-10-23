---
title: Garmin Heatmaps
date: 2026-10-22
description: "My Garmin Connect training as GitHub-style activity grids, refreshed every day and rendered when this static site is built."
image: /img/projects/garmin-heatmaps.png
image_alt: "Four heatmap grids drawn from sample data: running distance in green, elevation in orange, sleep in purple and overnight HRV in blue, June to September."
repo: https://github.com/EdSancha/garmin-heatmap
---

Each square is a day of the last year, and the stronger the colour, the further I ran.

{% include helpers/garmin-heatmap.html name="running" %}

The same year as elevation climbed, across every activity:

{% include helpers/garmin-heatmap.html name="climbing" %}

## How it works

- In October 2026 Garmin opened a [Personal API](https://developer.garmin.com/gc-developer-program/personal/personal-api/){:rel="external nofollow" target="_blank"}: any Garmin Connect user can create a key and pull their own data.
- Once a day, the workflow that deploys this site fetches my last year of activities, adds them up per day and draws each grid as an SVG. The page you are reading includes those SVGs as they are, with no JavaScript and no data file behind them.
- It only fetches what this page shows. Sleep and overnight HRV grids are supported but switched off, so that data stays in Garmin.
- The API key lives in a GitHub secret that only one step of the deploy can read. If Garmin is down or the key expires, the site deploys with the previous day's grids.

## Use it on your own site

The library has no dependencies. Clone it, list the grids you want in a small config file and run `node bin/garmin-heatmap.js build` in your site's build, or drop the `<garmin-heatmap>` web component into any page. Metrics include distance, elevation, training time, sleep, sleep score, overnight HRV and steps, in kilometres or miles. The [README](https://github.com/EdSancha/garmin-heatmap#readme){:rel="external nofollow" target="_blank"} covers setup and how to keep the key safe.

I wrote up how it came together in [Turning my Garmin data into GitHub-style heatmaps]({% post_url blog/2026-10-22-turning-my-garmin-data-into-github-style-heatmaps %}).
