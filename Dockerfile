FROM ruby:2.4.2-alpine3.6

WORKDIR  /app

ENV PATH /root/.yarn/bin:$PATH

COPY alphine_shared_install.sh ./
RUN /app/alphine_shared_install.sh

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY yarn.lock package.json ./
RUN yarn install

COPY . /app

RUN rake assets:precompile
