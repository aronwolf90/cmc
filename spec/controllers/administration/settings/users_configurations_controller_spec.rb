# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Settings::UserConfigurationsController, type: :controller do
  let(:model) { build_stubbed(:user, id: 1) }
  let(:form) { Administration::UserForm }
  let(:params) { {} }

  include_examples "standard edit action",
    Administration::SettingsUserConfigurations
  include_examples "standard update action",
    Administration::SettingsUserConfigurations,
    "/administration/settings/user_configurations/1/edit"
end