FROM ruby:2.4.2-alpine3.6
ARG MODUS="production"

WORKDIR  /app

ENV PATH /root/.yarn/bin:$PATH

COPY alphine_shared_install.sh ./
RUN /app/alphine_shared_install.sh

COPY Gemfile Gemfile.lock ./
RUN if [ $MODUS != "develop" ]; then bundle install; fi

COPY . /app

RUN if [ $MODUS != "develop" ]; then yarn install; fi

# speed up gitlab-cl
RUN if [ $MODUS = "gitlab-ci" ]; then mkdir -p /root/node_modules && cp -R node_modules /root/; fi
