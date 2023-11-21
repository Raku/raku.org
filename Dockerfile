FROM docker.io/rakudo-star:latest as builder

WORKDIR /usr/src/app

COPY . .
RUN zef install --deps-only .
RUN ./publish-sources.raku

FROM docker.io/caddy:latest
# Processed static files are written to ./online
COPY --from=builder /usr/src/app/online /usr/share/caddy
COPY Caddyfile /etc/caddy/Caddyfile

