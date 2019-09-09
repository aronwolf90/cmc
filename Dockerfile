FROM ruby:2.6.2-alpine3.9

ENV DOCKER true

WORKDIR  /app

RUN echo "export PATH=/app/bin:$PATH" >> ~/.profile

RUN apk add --update \
  tzdata postgresql-client \
  libressl-dev gnupg libstdc++ \
  less git g++ make \
  bash openssh-client \
  nodejs yarn vim tmux \
  postgresql-dev \
  grep

COPY --from=registry.gitlab.com/cmc_system/cmc:latest /usr/local/bundle /usr/local/bundle
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs $(nproc)

COPY --from=registry.gitlab.com/cmc_system/cmc:latest /app/node_modules /app/node_modules
COPY yarn.lock package.json ./
RUN yarn install

COPY --from=registry.gitlab.com/cmc_system/cmc:latest /app/public/assets /app/public/assets
COPY --from=registry.gitlab.com/cmc_system/cmc:latest /app/public/packs /app/public/packs
COPY --from=registry.gitlab.com/cmc_system/cmc:latest /app/tmp/cache/webpacker/ /app/tmp/cache/webpacker/
COPY --from=registry.gitlab.com/cmc_system/cmc:latest /app/tmp/cache/assets/ /app/tmp/cache/assets/

COPY . ./

RUN SECRET_KEY_BASE='9479a648d2fb' \
  DATABASE_URL=postgres://root:password@db%5Ftest/root \
  RAILS_ENV=production \
  bundle exec rake assets:precompile

CMD bundle exec puma -C config/puma.rb
