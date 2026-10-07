# frozen_string_literal: true

source "https://rubygems.org"

# Jekyll and only the plugins _config.yml loads. Pages builds with our own Actions workflow
# (pages.yml), so the github-pages gem's bundle isn't needed. Versions match what it pinned.
gem "jekyll", "~> 3.10"
gem "kramdown-parser-gfm", "~> 1.1"
# safe_yaml (via Jekyll 3) needs base64, which left Ruby's default gems in 3.4.
gem "base64"

group :jekyll_plugins do
  gem "jekyll-gist", "~> 1.5"
  gem "jekyll-paginate", "~> 1.1"
  gem "jekyll-seo-tag", "~> 2.8"
  gem "jekyll-sitemap", "~> 1.4"
end

# Needed by `jekyll serve` on Ruby >= 3.0.
gem "webrick", "~> 1.8"

# Used by `make check` to validate the generated site.
gem "html-proofer", "~> 5.0", group: :test
