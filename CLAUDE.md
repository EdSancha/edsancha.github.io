## Claude Code only

- The `new-post` and `cross-post` skills live in `.agents/skills/`; `.claude/skills/<name>` are symlinks to them, so Claude Code loads `new-post` when asked to write, add, convert or republish a post, and `cross-post` when asked to cross-post one to Substack and LinkedIn. Edit the files under `.agents/skills/`.
- `.claude/settings.json` has a SessionStart hook that runs `bundle config set --local path vendor/bundle` and `bundle install --quiet`, so gems land in `vendor/bundle` (gitignored) and `make` targets work straight away.
