# frozen_string_literal: true

source "https://rubygems.org"
source "https://rails-assets.org"

gem "rails", "~> 5.1.3"

# Fundamental
gem "apartment"
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
gem "kaminari", "~> 1.0.0"
gem "knock"
gem "lp_csv_exportable"
gem "migration_data"
gem "pg_search"
gem "pundit"
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
gem "bootstrap3-datetimepicker-rails"
gem "jquery-rails"
gem "momentjs-rails"
gem "turbolinks"
gem "select2-rails"

# Template
gem "font-awesome-rails"
gem "simple_form"
gem "slim-rails"

# preloaders
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
  gem "rubocop-rails_config", require: false
  gem "rubocop-rspec", require: false
  gem "web-console", ">= 3.3.0"
end

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "bullet"
  gem "rails-controller-testing"
  gem "factory_bot_rails"
  gem "foreman", "0.27.0"
  gem "rspec-rails"

  # static code analyzers
  gem "active_record_doctor"
  gem "brakeman"
  gem "rails_best_practices", require: false
  gem "rubycritic", require: false
  gem "traceroute"
end

group :test do
  gem "capybara"
  gem "cucumber-api-steps", require: false
  gem "cucumber-rails", require: false
  gem "database_cleaner", require: false
  gem "db-query-matchers"
  gem "selenium-webdriver", require: false
  gem "simplecov", require: false
  gem "rspec-cells"
  gem "shoulda-matchers"
  gem "timecop"
end
