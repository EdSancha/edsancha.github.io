# External link check for the built site (_site), run weekly by CI (see .github/workflows/ci.yml).
# Uses the Ruby API because html-proofer 5.2.2's --hydra/--typhoeus CLI
# flags fail to parse JSON with the current json gem.
require "html-proofer"

HTMLProofer.check_directory("./_site", {
  allow_hash_href: true,
  enforce_https: false,
  ignore_urls: [/^mailto:/, /amazon.com/, /apps.apple.com/, /itunes.apple.com/, /linkedin.com/, /instagram.com/],
  ignore_status_codes: [403, 429, 503],
  # Old posts link to many slow hosts. The defaults (50 parallel requests,
  # 10s connect timeout) made a different host time out (status 0) on each
  # run, so check fewer at once and wait longer.
  hydra: { max_concurrency: 8 },
  typhoeus: { connecttimeout: 30, timeout: 60 },
}).run
