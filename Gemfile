source "https://rubygems.org"

# github-pages 232 pulls nokogiri >= 1.16.2, which requires Ruby 3.0+.
# The macOS system Ruby (2.6) cannot resolve this Gemfile.
ruby ">= 3.0.0"

# GitHub Pages builds this site with the `github-pages` gem, which pins Jekyll
# and every supported plugin to the exact versions running in production.
# Pinning it here keeps local previews identical to the deployed site.
# See https://pages.github.com/versions/ for the current version table.
gem "github-pages", "~> 232", group: :jekyll_plugins

# Plugins enabled in _config.yml (both are bundled and version-pinned by
# github-pages; listed here to document what the site actually depends on):
#   jekyll-gist     1.5.0 -- {% gist %} tag
#   jekyll-paginate 1.1.0 -- blog pagination

# Not part of the stdlib since Ruby 3.0; required by `jekyll serve`.
gem "webrick", "~> 1.8"
