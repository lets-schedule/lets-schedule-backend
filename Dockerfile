ARG RUBY_VERSION=3.2.0
FROM ruby:$RUBY_VERSION

RUN apt-get update -qq && \
    apt-get install -y build-essential libvips && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

WORKDIR /rails

ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="production" \
    BUNDLE_WITHOUT="development"

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN bundle exec bootsnap precompile --gemfile app/ lib/

#RUN SECRET_KEY_BASE_DUMY=1 bundle exec rails assets:precompile

ENTRYPOINT ["/rails/bin/docker-entrypoint.sh"]

RUN bin/rails db:migrate

EXPOSE 3000
CMD ["./bin/rails", "server"]
