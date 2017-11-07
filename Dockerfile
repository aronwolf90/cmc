FROM registry.gitlab.com/cmc_system/cmc/cmc_prebuild

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . /app

