FROM registry.gitlab.com/cmc_system/cmc/cmc:test

WORKDIR  /app

ENV RAILS_ENV production

RUN ln -s /root/node_modules node_modules
COPY yarn.lock ./
RUN yarn install

COPY Gemfile Gemfile.lock ./
RUN bundle install --without test development

RUN mkdir -p /app/public/assets
RUN cp -r /assets /app/public/assets

COPY . /app

# secret key  and database url is not really used hear, it is only added to avoid the crash on compile
RUN SECRET_KEY_BASE='9479a648d2fb' DATABASE_URL=postgres://root:password@db%5Ftest/root rake assets:precompile

FROM ruby:2.5.1-alpine3.7

WORKDIR  /app

ENV BUNDLE_BIN /app/bin
ENV RAILS_ENV production

COPY . /app
COPY --from=0 /app/public/ /app/public/
COPY --from=0 /usr/local/ /usr/local/

RUN /app/alphine_minimum_shared_install.sh

CMD bundle exec puma -C config/puma.rb
