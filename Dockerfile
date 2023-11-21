FROM docker.io/perl:5.38.0 as builder

WORKDIR /usr/src/app

RUN cpan App::Mowyw
RUN cpan Plack
RUN cpan Mojo::UserAgent

COPY . .
RUN perl fetch-recent-blog-posts.pl
RUN mowyw

FROM docker.io/caddy:latest
# Processed static files are written to ./online
COPY --from=builder /usr/src/app/online /usr/share/caddy
COPY Caddyfile /etc/caddy/Caddyfile

