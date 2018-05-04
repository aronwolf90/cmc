# frozen_string_literal: true

Dry::Validation::Schema.configure do |config|
  config.messages = :i18n
  config.messages_file = Rails.root.join("config", "locales", "errors.yml")
end
