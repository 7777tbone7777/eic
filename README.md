# EIC Productions — website

Static site. One `index.html` with the CSS and JS inlined, plus `images/`.
No build step, no dependencies, no framework — open `index.html` and it works.

## Running it

```
python3 -m http.server 4174
```

Then http://localhost:4174.

## Hosting

Anything that serves static files: GitHub Pages, Cloudflare Pages, Vercel, Netlify.
`.nojekyll` is present so GitHub Pages serves the files as-is.

All asset paths are **relative**, so the site works from a domain root *and*
from a subpath like `https://<org>.github.io/eic/`.

## The two things to change

1. **Canonical / OpenGraph URL.** `index.html` currently declares
   `https://eicproductions.com/` in `<link rel="canonical">`, `og:url`,
   `og:image` and `twitter:image`. Point these at wherever the site actually
   lives — a canonical pointing somewhere the page isn't tells Google to
   ignore this one.

2. **`PORTAL_URL`.** The "Production Portal" links (nav, engine section,
   footer — 3 of them) point at `https://prodcomm.com/login`. Repoint them at
   the white-label host once it exists, so no EIC-facing link lands on a
   ProdComm-branded screen.

## Still outstanding

- **Copy sign-off.** Sean's bio, the taglines, the credits and the contact
  details come verbatim from eicproductions.com. Everything else — the
  services, the four formats, the five-phase process, the old-way/EIC-way
  comparison and the four audience blocks — **was written for this draft and
  has not been approved.** Get his sign-off before sharing the link widely.
- **`images/og-card.png` does not exist yet.** The OpenGraph tags reference a
  1200×630 share card that still needs designing. Until it exists, link
  previews will fall back to no image.

## How it degrades

- **JavaScript off:** the page renders complete and readable. The scroll
  reveal is opt-in (`.js-reveal`), added by the script only when it is about
  to drive the animation — so no script means no hidden sections.
- **IntersectionObserver missing or never firing:** a 3s watchdog drops the
  animation entirely and shows everything. A page that does not animate is
  fine; a blank page is not.
- **Background tab:** the rotating message thread and the confirmation counter
  hold rather than advance, so nothing lands mid-transition.
