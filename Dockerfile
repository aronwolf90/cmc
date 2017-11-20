FROM ruby:2.4.2-alpine3.6

WORKDIR /app

COPY alphine_shared_install.sh ./
RUN /app/alphine_shared_install.sh

COPY Gemfile Gemfile.lock ./
RUN bundle install

ENV PATH /root/.yarn/bin:$PATH

COPY . /app

RUN yarn install

# speed up gitlab-cl
RUN ln node_modules /root/node_modules
