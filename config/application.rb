# frozen_string_literal: true

require_relative "boot"

require "rails/all"
require_relative "../lib/apartment_middleware"
require_relative "../lib/paginator"
require_relative "../lib/google_calender_client"

# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CMC
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_record.belongs_to_required_by_default = false

    config.time_zone = "Berlin"

    config.middleware.insert_before Warden::Manager, ApartmentMiddleware

    config.active_record.schema_format = :sql

    config.active_record.dump_schemas = "test-organization"

    config.action_controller.include_all_helpers = false

    config.action_mailer.default_url_options = {
      host: lambda { ApplicationHelper.organization_url }
    }

    config.active_job.queue_adapter = :sidekiq
  end
end
