# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Settings::UsersController, type: :controller do
  let(:model) { build_stubbed(:user, id: 1) }
  let(:form) { Administration::UserForm }
  let(:params) { {} }

  include_examples "standart edit action", Administration::SettingsUsers
  include_examples "standart update action", Administration::SettingsUsers,
    "/administration/settings/users/1/edit"
end
