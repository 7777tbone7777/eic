# A four-file static site. Caddy rather than nginx because Caddy reads Railway's
# $PORT straight from the environment, with no entrypoint templating.
#
# Only the files that are actually served get copied — the README, this
# Dockerfile and the Caddyfile stay out of the web root.
FROM caddy:2-alpine

COPY Caddyfile /etc/caddy/Caddyfile
COPY index.html /srv/index.html
COPY images /srv/images

# Caddy's own image already runs the server; nothing else to declare.
