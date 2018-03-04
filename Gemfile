# frozen_string_literal: true

source "https://rubygems.org"

gem "rails", "~> 5.1.3"

# Fundamental
gem "pg"
gem "puma", "~> 3.7"

# Engines
gem "devise"
gem "devise_invitable"

# Lovlevel
gem "active_model_serializers"
gem "carrierwave"
gem "config"
gem "dry-transaction"
gem "hash_mapper"
gem "knock"
gem "seed-fu"
gem "uglifier", ">= 1.3.0"
gem "webpacker", "~> 3.0"

# Trailblazer
gem "cells-rails"
gem "cells-slim"
gem "trailblazer"
gem "trailblazer-cells"
gem "trailblazer-rails", "~> 2.1"

# Preprocessors
gem "coffee-rails", "~> 4.2"
gem "sass-rails", "~> 5.0"

# Frontent libraries
gem "bootstrap", "~> 4.0.0.beta2.1"
gem "jquery-rails"
gem "turbolinks"

# Template
gem "font-awesome-rails"
gem "jbuilder", "~> 2.5"
gem "simple_form"
gem "slim-rails"

# Services
gem "sentry-raven"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "capybara", "~> 2.13"
  gem "cucumber-api-steps", require: false
  gem "cucumber-rails", require: false
  # required only be cucumber-rails, not used in the project
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "selenium-webdriver"

  # static code analizers
  gem "rubycritic", require: false
  gem "traceroute"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "shoulda-matchers"
  gem "timecop"
end
