# frozen_string_literal: true

source "https://rubygems.org"

# Jekyll and only the plugins _config.yml loads. Pages builds with our own Actions workflow
# (pages.yml). Jekyll 4 brings its own kramdown-parser-gfm, webrick and base64.
gem "jekyll", "~> 4.4"

group :jekyll_plugins do
  gem "jekyll-gist", "~> 1.5"
  gem "jekyll-paginate", "~> 1.1"
  gem "jekyll-seo-tag", "~> 2.9"
  gem "jekyll-sitemap", "~> 1.4"
end

# Used by `make check` to validate the generated site.
gem "html-proofer", "~> 5.0", group: :test
