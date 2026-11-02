# External link check for the built site (_site), run weekly by CI (see .github/workflows/ci.yml).
# Uses the Ruby API because html-proofer 5.2.2's --hydra/--typhoeus CLI
# flags fail to parse JSON with the current json gem.
require "html-proofer"

runner = HTMLProofer.check_directory("./_site", {
  allow_hash_href: true,
  enforce_https: false,
  ignore_urls: [/^mailto:/, /amazon.com/, /apps.apple.com/, /itunes.apple.com/, /linkedin.com/, /instagram.com/],
  ignore_status_codes: [403, 429, 503],
  # Old posts link to many slow hosts. The defaults (50 parallel requests,
  # 10s connect timeout) made a different host time out (status 0) on each
  # run, so check fewer at once and wait longer.
  hydra: { max_concurrency: 8 },
  typhoeus: { connecttimeout: 30, timeout: 60 },
})

# html-proofer exits 1 on any failure. Slow hosts time out from CI on and off, so
# a timeout alone only warns, and definite errors (404s and the like) fail the job.
begin
  runner.run
rescue SystemExit
end

timeouts, broken = runner.failed_checks.partition do |failure|
  failure.description.include?("got a time out")
end
timeouts.each { |failure| puts "::warning::#{failure.description} (#{failure.path})" }
exit(1) unless broken.empty?
