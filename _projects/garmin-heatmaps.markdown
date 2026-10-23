---
title: Garmin Heatmaps
date: 2026-10-22
description: "Garmin Connect training data as GitHub-style activity grids for static sites, refreshed every day and rendered when the site is built."
image: /img/projects/garmin-heatmaps.png
image_alt: "Four heatmap grids drawn from made-up sample data: running distance in green, elevation in orange, sleep in purple and overnight HRV in blue, June to September."
repo: https://github.com/EdSancha/garmin-heatmap
image_caption: "Made-up sample data, to show what the grids look like."
---

Each square is a day, and the stronger the colour, the bigger the day: further run, more climbed, longer slept, higher overnight HRV. Every grid has a headline number for the period and a legend, and every square has a tooltip with its date and value.

<figure>
  <img src="{{ '/img/projects/garmin-heatmaps.png' | relative_url }}" alt="Four heatmap grids drawn from made-up sample data: running distance in green, elevation in orange, sleep in purple and overnight HRV in blue, June to September.">
  <figcaption>Made-up sample data, to show what the grids look like. It isn't my training; my own grids will live elsewhere on this site.</figcaption>
</figure>

## How it works

- In October 2026 Garmin opened a [Personal API](https://developer.garmin.com/gc-developer-program/personal/personal-api/){:rel="external nofollow" target="_blank"}: any Garmin Connect user can create a key and pull their own data.
- Once a day, the workflow that deploys this site fetches my last year of activities, adds them up per day and draws each grid as an SVG, ready to include in any page as it is, with no JavaScript and no data file behind it.
- It only fetches what the site's grids need. Sleep and overnight HRV grids are supported but switched off, so that data stays in Garmin.
- The API key lives in a GitHub secret that only one step of the deploy can read. If Garmin is down or the key expires, the site deploys with the previous day's grids.

## Use it on your own site

The library has no dependencies. Clone it, list the grids you want in a small config file and run `node bin/garmin-heatmap.js build` in your site's build, or drop the `<garmin-heatmap>` web component into any page. Metrics include distance, elevation, training time, sleep, sleep score, overnight HRV and steps, in kilometres or miles. The [README](https://github.com/EdSancha/garmin-heatmap#readme){:rel="external nofollow" target="_blank"} covers setup and how to keep the key safe.

I wrote up how it came together in [Turning my Garmin data into GitHub-style heatmaps]({% post_url blog/2026-10-22-turning-my-garmin-data-into-github-style-heatmaps %}).
