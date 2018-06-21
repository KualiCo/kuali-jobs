FROM "jekyll/jekyll:3.8"

COPY . /srv/jekyll

EXPOSE 4000

WORKDIR /srv/jekyll

ENTRYPOINT ["/usr/jekyll/bin/jekyll", "serve", "/srv/jekyll"]
