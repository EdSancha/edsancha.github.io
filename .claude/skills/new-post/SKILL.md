---
name: new-post
description: Add a blog post to edsancha.com, including importing an article first published on Substack or the Salitre Coaching blog. Use when asked to write, add, convert or republish a post.
---

# Add a post

Posts live in `blog/_posts/` and are rendered by `_layouts/post.html`. Weekly link roundups are ordinary posts with `intro: last-week-reads` in front matter, which pulls in `_includes/intro-last-week-reads.html` above the body.

## 1. File name

`blog/_posts/YYYY-MM-DD-post-title-slug.markdown`

- `YYYY-MM-DD` is the publication date (for republished articles, the original publication date).
- Slug: lowercase, words separated by hyphens, no stop-word trimming needed.

## 2. Front matter

```yaml
---
layout: post
title: "Title of the Post in Title Case"
date: YYYY-MM-DD
author: "Eduardo Diaz Sancha"
timeToRead: "3 minutes read"
description: "One plain sentence describing the post."
categories: leadership management
image: "https://example.com/featured.jpg"   # optional, used for previews
# Only for articles first published elsewhere:
source_name: "Substack"
source_url: "https://leadershipendurance.substack.com/p/slug"
source_date: "7th March, 2025"
canonical_url: "https://leadershipendurance.substack.com/p/slug"   # only when source_url is the exact article
---
```

- `timeToRead`: word count divided by 225, rounded, as "N minutes read".
- `description`: shown on the index, in RSS and in meta tags. No prefix like "From Substack:".
- `categories`: space-separated lowercase words. They appear as links on the post and the index and group posts on `/blog/categories/`, and they form part of the post URL, so never change them on a published post. Existing ones: `leadership management running training 10k tools development me reading`.
- `source_*`: the layout renders "Originally published on {source_name}, {source_date}" linking to `source_url`. Do not also write the note by hand in the body.
- `canonical_url`: sets `<link rel="canonical">`. Use it only when `source_url` is the exact article URL (not a newsletter home page); otherwise leave it out and the page is its own canonical.

## 3. Body

- Standard Markdown (kramdown). Headings start at `##` (the layout renders `title` as `h1`).
- Convert any HTML from the source to Markdown. Images become `![alt text](URL)` inline where they appeared in the original.
- Keep the author's voice; do not add or remove opinions.
- Optional call-to-action at the end, separated with `---`:

```markdown
---

**Curious what a customized program would look like for your goals?**
[Reach out](https://www.salitre.co/contact) and we'll build the next chapter together.
```

## 4. Verify

```sh
make check
```

Then open `http://localhost:4000/blog/` with `make serve` and confirm the post appears first with the right date and description. The post must render in light and dark mode (code blocks and images included).

## Sources this site republishes from

- Substack: https://leadershipendurance.substack.com (leadership and endurance essays)
- Salitre Coaching blog: https://www.salitre.co/blog (training write-ups)
