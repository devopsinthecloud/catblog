FROM ruby:3.0-alpine

RUN apk update && apk add tzdata openssl libpq libxslt

RUN adduser -D deploy

WORKDIR /app

RUN bundle config set --local deployment true
RUN bundle config set --local without development test

COPY Gemfile* ./
RUN mkdir -p vendor
COPY vendor/cache vendor/cache

RUN apk add --virtual .build-deps git build-base ruby-dev zlib-dev postgresql-dev linux-headers && bundle install --local && apk del .build-deps

COPY . .

RUN mkdir -p tmp/pids log
RUN chown -R deploy tmp log

USER deploy
ENV RAILS_LOG_TO_STDOUT 1
ENV RAILS_ENV production
ENV MALLOC_ARENA_MAX 2

EXPOSE 3000
CMD bundle exec puma