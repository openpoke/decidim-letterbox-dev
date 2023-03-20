FROM ruby:2.7 AS builder

RUN apt-get update && apt-get upgrade -y && apt-get install gnupg2 && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y nodejs yarn \
    build-essential \
    postgresql-client \
    libpq-dev && \
    apt-get clean

RUN gem install bundler:2.3.20 && \
    # throw errors if Gemfile has been modified since Gemfile.lock
    bundle config --global frozen 1


WORKDIR /app

# Copy package dependencies files only to ensure maximum cache hit
COPY ./package-lock.json /app/package-lock.json
COPY ./package.json /app/package.json
COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock

RUN bundle config --local without 'development test' && \
    bundle install -j4 --retry 3 && \
    # Remove unneeded gems
    bundle clean --force && \
    # Remove unneeded files from installed gems (cache, *.o, *.c)
    rm -rf /usr/local/bundle/cache && \
    find /usr/local/bundle/ -name "*.c" -delete && \
    find /usr/local/bundle/ -name "*.o" -delete && \
    find /usr/local/bundle/ -name ".git" -exec rm -rf {} + && \
    find /usr/local/bundle/ -name ".github" -exec rm -rf {} + && \
    # whkhtmltopdf has binaries for all platforms, we don't need them once uncompressed
    rm -rf /usr/local/bundle/gems/wkhtmltopdf-binary-*/bin/*.gz && \
    # Remove additional unneded decidim files
    find /usr/local/bundle/ -name "decidim_app-design" -exec rm -rf {} + && \
    find /usr/local/bundle/ -name "spec" -exec rm -rf {} +

RUN npm ci

# copy the rest of files
COPY . /app

# Compile assets with Webpacker or Sprockets
#
# Notes:
#   1. Executing "assets:precompile" runs "webpacker:compile", too
#   2. For an app using encrypted credentials, Rails raises a `MissingKeyError`
#      if the master key is missing. Because on CI there is no master key,
#      we hide the credentials while compiling assets (by renaming them before and after)
#
RUN mv config/credentials.yml.enc config/credentials.yml.enc.bak 2>/dev/null || true
RUN mv config/credentials config/credentials.bak 2>/dev/null || true
# prevent deface compiling to avoid initialize the database
RUN sed -ie '/^Rails\.application\.configure/a config.deface.enabled = false' config/environments/production.rb 2>/dev/null || true

RUN RAILS_ENV=production \
    SECRET_KEY_BASE=dummy \
    RAILS_MASTER_KEY=dummy \
    DB_ADAPTER=nulldb \
    bundle exec rails assets:precompile

RUN sed -ie '/^config\.deface\.enabled = false/d' config/environments/production.rb 2>/dev/null || true
RUN mv config/credentials.yml.enc.bak config/credentials.yml.enc 2>/dev/null || true
RUN mv config/credentials.bak config/credentials 2>/dev/null || true

RUN rm -rf node_modules tmp/cache vendor/bundle test spec app/packs .git

# This image is for production env only
FROM ruby:2.7-slim AS final

RUN apt-get update && \
    apt-get install -y postgresql-client imagemagick && \
    apt-get clean

EXPOSE 3000

ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_ENV production

ARG COMMIT_SHA
ARG COMMIT_TIME
ARG COMMIT_VERSION

ENV COMMIT_SHA ${COMMIT_SHA}
ENV COMMIT_TIME ${COMMIT_TIME}
ENV COMMIT_VERSION ${COMMIT_VERSION}

# Add user
RUN addgroup --system --gid 1000 app && \
    adduser --system --uid 1000 --home /app --group app

COPY --from=builder --chown=app:app /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder --chown=app:app /app /app

USER app
CMD ["/app/init.sh"]