FROM ruby:2.4.2-alpine3.6

WORKDIR  /app

ENV PATH /root/.yarn/bin:$PATH
ENV BUNDLE_BIN /app/bin

COPY alphine_shared_install.sh ./
RUN /app/alphine_shared_install.sh

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . /app

RUN yarn install

RUN rake assets:precompile
