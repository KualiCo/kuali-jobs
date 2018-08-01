FROM jekyll/jekyll:3.8

WORKDIR /srv/jekyll
COPY --chown="jekyll:jekyll" . /srv/jekyll

RUN \
  /usr/jekyll/bin/bundle install && \
  /usr/jekyll/bin/bundle exec jekyll build

EXPOSE 4000
ENTRYPOINT ["/usr/jekyll/bin/jekyll", "serve", "/srv/jekyll"]
