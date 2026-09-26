# sameni.info

Source for [sameni.info](https://sameni.info), the personal homepage of Reza Sameni. Built with Jekyll and served by GitHub Pages. This file is not published.

## Editing

| What | Where |
| --- | --- |
| Homepage bio and contact | `index.md` (Markdown below the front matter) |
| Name, photo and titles at the top of the homepage | `profile:` in the front matter of `index.md` |
| Email / lab / Scholar / GitHub / LinkedIn links | `social_links:` in `_config.yml` |
| Header menu | `header_pages:` in `_config.yml` |
| Teaching page | `teaching.md` |
| Course pages | `courses/` |
| Colors, fonts, spacing | `assets/css/main.css` (tokens at the top, with a dark-mode block) |

A page whose front matter contains `redirect_to: <url>` becomes a redirect, and its header menu link points straight at that URL (see `research.md`, `publications.md`, `team.md`).

Pages with `title: ""` get no page heading, which is useful when the Markdown supplies its own (the course pages do this).

Add `math: true` to a page's front matter to load MathJax; then write `$$ x_{k+1} = A x_k + w_k $$` in Markdown.

## Domain

`CNAME` must contain exactly `sameni.info`. Don't add it to `exclude:` in `_config.yml`.

## Local preview

```sh
bundle install
bundle exec jekyll serve
```

Then open http://localhost:4000.

## Deployment

Pushing to `master` runs `.github/workflows/jekyll.yml`, which builds and deploys to GitHub Pages (Settings → Pages → Source: GitHub Actions). The site also builds with the classic "Deploy from a branch" mode because it uses no external theme and plain CSS.
