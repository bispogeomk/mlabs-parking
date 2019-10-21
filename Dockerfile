FROM ruby:2.6-alpine AS build-env

ARG RAILS_ROOT=/app
ARG BUILD_PACKAGES="build-base curl-dev git tzdata"
ARG DEV_PACKAGES="postgresql-dev yaml-dev zlib-dev sqlite-dev nodejs yarn"
ARG PACKAGES="tzdata postgresql-client sqlite nodejs bash"
ARG RUBY_PACKAGES="tzdata"

ENV RAILS_ENV=development
ENV NODE_ENV=development
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"

RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES $PACKAGES

WORKDIR $RAILS_ROOT
COPY ./source/mlabs-parking .
# COPY ./source/Gemfile* ./source/package.json ./source/yarn.lock ./
# install rubygem
# COPY ./source/Gemfile ./source/Gemfile.lock $RAILS_ROOT/
# RUN bundle config --global frozen 1 \
#     && bundle install --without development:test:assets -j4 --retry 3 --path=vendor/bundle

RUN gem install bundler
RUN bundle install

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]