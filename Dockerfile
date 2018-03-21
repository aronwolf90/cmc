FROM ruby:2.4.2-alpine3.7

WORKDIR  /app

ENV PATH /root/.yarn/bin:$PATH
ENV BUNDLE_BIN /app/bin
ENV RAILS_ENV production

COPY alphine_shared_install.sh ./
COPY alphine_minimum_shared_install.sh ./
RUN /app/alphine_shared_install.sh

COPY yarn.lock ./
RUN yarn install

COPY Gemfile Gemfile.lock ./
RUN bundle install --without test development

COPY . /app

# secret key is not really used hear, it is only added to avoid the crash on compile
RUN SECRET_KEY_BASE='9479a648d2fb' rake assets:precompile

FROM ruby:2.4.2-alpine3.7

WORKDIR  /app

ENV BUNDLE_BIN /app/bin
ENV RAILS_ENV production

COPY . /app
COPY --from=0 /app/public/ /app/public/
COPY --from=0 /usr/local/bundle /usr/local/bundle

RUN /app/alphine_minimum_shared_install.sh

CMD bundle exec puma -C config/puma.rb
