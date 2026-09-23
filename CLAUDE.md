## Claude Code only

- `.claude/skills/new-post/` is a Claude Code skill: it loads automatically when asked to write, add, convert or republish a post. Other tools read the same file by path (see Conventions in AGENTS.md).
- `.claude/settings.json` has a SessionStart hook that runs `bundle config set --local path vendor/bundle` and `bundle install --quiet`, so gems land in `vendor/bundle` (gitignored) and `make` targets work straight away.
