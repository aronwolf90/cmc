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
gem "migration_data"
gem "dry-transaction"
gem "hash_mapper"
gem "kaminari", "~> 1.0.0"
gem "knock"
gem "seed-fu"
gem "uglifier"
gem "webpacker"

# ruby extensions
gem "attr_extras"
gem "numeric"

# Trailblazer
gem "cells-rails"
gem "cells-slim"
gem "kaminari-cells"
gem "reform", ">= 2.3.0.rc1"
gem "reform-rails"
gem "trailblazer"
gem "trailblazer-cells"
gem "trailblazer-rails", "~> 2.1"

# Preprocessors
gem "coffee-rails"
gem "sass-rails"

# Frontent libraries
gem "bootstrap", "~> 4"
gem "jquery-rails"
gem "turbolinks"

# Template
gem "font-awesome-rails"
gem "simple_form"
gem "slim-rails"

# preloads
gem "bootsnap", require: false
gem "spring"
gem "spring-commands-rspec"
gem "spring-watcher-listen"

group :production do
  gem "sentry-raven"
end

group :development do
  gem "guard-rspec", require: false
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "web-console", ">= 3.3.0"
end

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "rspec-rails"

  # static code analyzers
  gem "rubycritic", require: false
  gem "traceroute", require: false
end

group :test do
  gem "capybara"
  gem "cucumber-api-steps", require: false
  gem "cucumber-rails", require: false
  gem "database_cleaner", require: false
  gem "selenium-webdriver", require: false
  gem "rspec-cells"
  gem "shoulda-matchers"
  gem "timecop"
end
