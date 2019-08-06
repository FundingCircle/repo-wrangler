FROM ruby:2.6.3-alpine

WORKDIR /work

RUN apk add --update --no-cache \
  build-base

ADD ./Gemfile /work
RUN bundle install --retry 3 --jobs 3
