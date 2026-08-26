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

## Deploying on Railway

`Dockerfile` + `Caddyfile` are here because Railway has nothing to autodetect
otherwise — the repo is four static files with no package.json, no build and no
server, so a bare deploy has nothing to start.

Caddy rather than nginx because it reads Railway's `$PORT` straight from the
environment with no entrypoint templating. Only the served files are copied
into the image; the README, Dockerfile and Caddyfile stay out of the web root.

Cache headers are deliberately short: the image filenames are not
content-hashed, so a long immutable cache would strand viewers on an old
headshot after it is replaced.

Verified locally with Caddy (`caddy validate`, then served with `PORT` set):
binds the assigned port, `/` returns the page at max-age=300, images return
max-age=86400, gzip negotiates 52 KB down to 15 KB, unknown paths 404 properly.
The image itself was NOT build-tested — there is no Docker daemon on the
machine it was written on, so the first Railway build is the real test.

## Still outstanding

- **Copy sign-off.** Sean's bio, the taglines, the credits and the contact
  details come verbatim from eicproductions.com. Everything else — the
  services, the four formats, the five-phase process, the old-way/EIC-way
  comparison and the four audience blocks — **was written for this draft and
  has not been approved.** Get his sign-off before sharing the link widely.

## How it degrades

- **JavaScript off:** the page renders complete and readable. The scroll
  reveal is opt-in (`.js-reveal`), added by the script only when it is about
  to drive the animation — so no script means no hidden sections.
- **IntersectionObserver missing or never firing:** a 3s watchdog drops the
  animation entirely and shows everything. A page that does not animate is
  fine; a blank page is not.
- **Background tab:** the rotating message thread and the confirmation counter
  hold rather than advance, so nothing lands mid-transition.
