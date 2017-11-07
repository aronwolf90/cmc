FROM cmc_prebuild

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . /app

