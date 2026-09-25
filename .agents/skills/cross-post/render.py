#!/usr/bin/env python3
"""Render a post body as paste-ready HTML for the Substack and LinkedIn editors.

Usage: render.py blog/_posts/YYYY-MM-DD-slug.markdown OUT_DIR

Writes to OUT_DIR:
  substack.html, linkedin.html    the body as HTML (kramdown, same renderer as the site)
  paste-substack.js, paste-linkedin.js
                                  a snippet for the Chrome javascript tool: pastes the
                                  HTML into the focused editor as a synthetic paste event
                                  and returns counts of h2/li/a/hr to check against.

Differences between the variants:
  - Both: links to other edsancha.com posts that have a canonical_url are rewritten to
    that Substack URL, so newsletter readers stay on the newsletter.
  - Substack: the "[Subscribe now](...)" line is dropped (Substack adds its own button).
  - LinkedIn: the Subscribe line is kept, pointing at Substack.

Run from the repository root (it uses the repo's Bundler setup for kramdown).
"""
import json
import os
import re
import subprocess
import sys

POST_LINK = re.compile(
    r"https?://(?:www\.)?edsancha\.com/blog/(?:[\w-]+/)*(\d{4})/(\d{2})/(\d{2})/([\w-]+)\.html"
)
SUBSCRIBE = re.compile(r"^\[Subscribe now\]\([^)]*\)\s*$", re.M)

PASTE_JS = """const html = %s;
const ed = document.activeElement && document.activeElement.closest('[contenteditable="true"]');
if (!ed) throw new Error('Click into the editor body first');
const dt = new DataTransfer();
dt.setData('text/html', html);
dt.setData('text/plain', ed.innerText || ' ');
ed.dispatchEvent(new ClipboardEvent('paste', {clipboardData: dt, bubbles: true, cancelable: true}));
await new Promise(r => setTimeout(r, 1500));
({expected: %s, got: {h2: ed.querySelectorAll('h2,h3').length, li: ed.querySelectorAll('li').length,
  a: ed.querySelectorAll('a').length, hr: ed.querySelectorAll('hr').length}})
"""


def front_matter_and_body(text):
    parts = text.split("---\n", 2)
    if len(parts) < 3 or parts[0].strip():
        sys.exit("No front matter found")
    return parts[1], parts[2]


def canonical_for(match):
    y, m, d, slug = match.groups()
    for ext in ("markdown", "md"):
        path = f"blog/_posts/{y}-{m}-{d}-{slug}.{ext}"
        if os.path.exists(path):
            fm, _ = front_matter_and_body(open(path, encoding="utf-8").read())
            found = re.search(r'^canonical_url:\s*"?([^"\n]+)"?', fm, re.M)
            return found.group(1) if found else match.group(0)
    return match.group(0)


def kramdown(markdown):
    ruby = "print Kramdown::Document.new(STDIN.read, auto_ids: false).to_html"
    out = subprocess.run(
        ["bundle", "exec", "ruby", "-rkramdown", "-e", ruby],
        input=markdown, capture_output=True, text=True, check=True,
    )
    # Editors turn whitespace between tags into empty paragraphs.
    return re.sub(r">\s+<", "><", out.stdout).strip()


def counts(html):
    return {tag: len(re.findall(p, html)) for tag, p in
            {"h2": r"<h[23][ >]", "li": r"<li[ >]", "a": r"<a ", "hr": r"<hr"}.items()}


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    post, out_dir = sys.argv[1], sys.argv[2]
    os.makedirs(out_dir, exist_ok=True)
    _, body = front_matter_and_body(open(post, encoding="utf-8").read())
    body = POST_LINK.sub(canonical_for, body).strip() + "\n"
    variants = {"substack": SUBSCRIBE.sub("", body), "linkedin": body}
    for name, markdown in variants.items():
        html = kramdown(markdown)
        with open(os.path.join(out_dir, f"{name}.html"), "w", encoding="utf-8") as f:
            f.write(html)
        with open(os.path.join(out_dir, f"paste-{name}.js"), "w", encoding="utf-8") as f:
            f.write(PASTE_JS % (json.dumps(html), json.dumps(counts(html))))
        print(f"{name}: {counts(html)}")
    for link in sorted(set(POST_LINK.findall(body))):
        print("warning: edsancha.com post link has no canonical_url:", "/".join(link))


if __name__ == "__main__":
    main()
