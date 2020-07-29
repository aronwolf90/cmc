FROM ruby:2.6.2-alpine3.9

ENV DOCKER true

WORKDIR  /app

COPY Gemfile Gemfile.lock yarn.lock package.json ./
RUN echo "export PATH=/app/bin:$PATH" >> ~/.profile && \
  apk add --update \
  tzdata postgresql-client \
  libressl-dev gnupg libstdc++ \
  less git g++ make \
  bash openssh-client \
  nodejs yarn vim tmux \
  postgresql-dev \
  grep && \
  bundle install --jobs $(nproc) && \
  yarn install

COPY . ./

RUN SECRET_KEY_BASE='9479a648d2fb' \
  DATABASE_URL=postgres://root:password@db%5Ftest/root \
  RAILS_ENV=production \
  bundle exec rake assets:precompile

CMD bundle exec puma -C config/puma.rb
