# _includes/

- **Settings menu** (`settings-menu.html`): the theme and appearance rules are in `css/AGENTS.md`.
- **A language picker** is designed into `_includes/settings-menu.html` but not rendered, because nothing is translated. Wiring it up needs translated content and a URL scheme first (no i18n plugin is on the GitHub Pages allowlist, so it would be per-locale directories plus a `lang` key in front matter); the menu then gains a third group in the same shape as the other two.
