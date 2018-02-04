FROM ruby:2.4.2-alpine3.6

WORKDIR  /app

ENV PATH /root/.yarn/bin:$PATH
ENV BUNDLE_BIN /app/bin

COPY alphine_shared_install.sh ./
RUN /app/alphine_shared_install.sh

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . /app

# secret key is not really used hear, it is only added to avoid the crash on compile
RUN RAILS_ENV=production SECRET_KEY_BASE='9479a648d2fb' rake assets:precompile
