## Claude Code only

- The `new-post` skill lives in `.agents/skills/new-post/`; `.claude/skills/new-post` is a symlink to it, so Claude Code loads it automatically when asked to write, add, convert or republish a post. Edit the files under `.agents/skills/`.
- `.claude/settings.json` has a SessionStart hook that runs `bundle config set --local path vendor/bundle` and `bundle install --quiet`, so gems land in `vendor/bundle` (gitignored) and `make` targets work straight away.
