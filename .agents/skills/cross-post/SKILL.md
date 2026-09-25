---
name: cross-post
description: Cross-post a finished Leadership Endurance essay from this repo to Substack, the LinkedIn newsletter and a LinkedIn feed post, then point the edsancha.com copy at the Substack original and update the brain notes. Use when a post is committed here and Ed asks to cross-post, publish or share it.
---

# Cross-post an essay

Substack is canonical. The LinkedIn newsletter gets the same text the same day, a LinkedIn feed post announces it, and edsancha.com republishes with `canonical_url` pointing at Substack. Background: `~/Work/brain/10-projects/leadership-endurance/README.md`.

**Ed publishes and Ed merges.** Set up drafts and open PRs; never click Publish on Substack or LinkedIn and never merge a PR here (every push to `master` goes live). Stop and hand over at each of those points.

## 1. Find where the post stands

- The post: `blog/_posts/YYYY-MM-DD-slug.markdown`, usually on a `post/<slug>` branch.
- The draft note in `~/Work/brain/10-projects/leadership-endurance/<slug>.md` has a "Before publishing" checklist (fact checks, numbers to confirm). Surface the open items to Ed; don't tick them yourself.
- `git fetch` and compare the branch with `origin/master`. Ed may already have merged an earlier version (squash-merged, so the branch still looks unmerged). If so, put follow-up commits on a new branch from `origin/master`.

## 2. Review the copy

Read the whole post and list typos, grammar slips and garbled sentences with a proposed fix for each. Keep Ed's voice: fix errors, don't restyle. Apply the fixes Ed approves as one commit before making any drafts, because published Substack and LinkedIn copies are painful to correct.

## 3. Render paste-ready HTML

From the repo root, with Bundler on `PATH` (see `AGENTS.md`):

```sh
.agents/skills/cross-post/render.py blog/_posts/YYYY-MM-DD-slug.markdown <scratchpad>/cross-post
```

It prints the expected heading, list item, link and rule counts per variant, rewrites links to earlier edsancha.com posts to their Substack `canonical_url`, drops the "Subscribe now" line for Substack and keeps it for LinkedIn. A warning means a linked post has no `canonical_url`; decide with Ed whether to keep that link.

## 4. Drafts in Chrome

Load the claude-in-chrome skill and tools, open a new tab in the MCP group. Ed is already signed in to both sites.

**Substack**
1. Open `https://leadershipendurance.substack.com/publish/post?type=newsletter` and wait for the editor to load.
2. Click the Title field and type the post `title`; click the subtitle field and type the `description`.
3. Click into the body ("Start writing..."), then run `paste-substack.js` with the javascript tool (pass the file's contents as the code). Check that `got` matches `expected` and take a screenshot. The header shows "Saved".
4. Note the draft URL (`/publish/post/<id>`) for Ed.

**LinkedIn newsletter**
1. Open `https://www.linkedin.com/article/new/` (it takes a few seconds to load).
2. Confirm the author block reads "Leadership Endurance" (the newsletter), not a plain article.
3. Click Title and type the title. A long title wraps to two lines and pushes the body down, so take a screenshot before clicking the body.
4. Click the body ("Write here..."), run `paste-linkedin.js`, compare the counts, and use `find` to confirm "Draft - saved". Note the `/article/edit/<id>/` URL.

Close the tab. Tell Ed what's left in each editor: a header or cover image, Substack social preview, and LinkedIn's **Next** step, which asks for the announcement text.

## 5. LinkedIn feed post

Draft the announcement for Ed to paste: a hook with the essay's sharpest numbers, the coach's-eye twist, two or three takeaways, then "Link in the first comment" (links in the post body cut its reach) and two or three hashtags. It doubles as the text for LinkedIn's newsletter **Next** step.

## 6. After Ed publishes on Substack

Ed sends the `/p/` URL. Read `og:image` and `datePublished` from the page (`curl -sL <url>`), then on a branch from `origin/master` add:

```yaml
source_name: "Substack"
source_url: "https://leadershipendurance.substack.com/p/<slug>"
source_date: "24th September, 2026"   # from datePublished
canonical_url: "https://leadershipendurance.substack.com/p/<slug>"
image: "<og:image, with &amp; decoded to &>"
```

If `datePublished` differs from the file date, rename the file to match the Substack date (see `new-post`). Run `make check`, confirm `_site` has `<link rel="canonical" href="<substack url>">` and the "Originally published on Substack" line, push, and open a PR. Ed merges it.

## 7. Close the loop

When Ed confirms everything is out (and asks for the brain update):

- Hub note `10-projects/leadership-endurance/README.md`: tick the next action, add a dated log line with the Substack URL, where else it went, and the PR numbers.
- Draft note: set `status: published`, drop "(draft)" from the heading, replace the status line with the published links, tick only the checklist items that were actually done.
- Commit in `~/Work/brain` with `notes: <what>`; don't push (`sync.sh` does).
- Add the edition to the `leadership-endurance-newsletter` auto-memory.
- After Ed merges: `git switch master && git pull --ff-only` here and delete the merged local branches.
