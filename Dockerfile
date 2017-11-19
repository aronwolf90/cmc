FROM registry.gitlab.com/cmc_system/cmc/cmc_prebuild

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

ENV PATH /root/.yarn/bin:$PATH
COPY yarn.lock ./
COPY package.json ./
RUN yarn  install

COPY . /app

