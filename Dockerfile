FROM ruby:2.6.3-alpine

WORKDIR /work

RUN apk add --update --no-cache \
  build-base \
  git

ADD ./Gemfile /work
RUN bundle install --retry 3 --jobs 3

ADD . /work
RUN set -ex && \
    GITHUB_TOOLS_GIT_URL='https://github.com/FundingCircle/github-tools.git' && \
    git clone "$GITHUB_TOOLS_GIT_URL" ./workspace/github-tools -b find-no-codeowners && \
    cd ./workspace/github-tools/ruby && \
    bundle install --retry 3 --jobs 3
