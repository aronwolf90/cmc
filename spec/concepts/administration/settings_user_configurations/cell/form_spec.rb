# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::SettingsUserConfigurations::Cell::Form, type: :cell do
  controller Administration::UsersController

  subject { cell(described_class, form, current_user: user).() }

  let(:form) { Administration::SettingsUserConfigurationForm.new(user) }
  let(:user) { build_stubbed(:user)  }

  it { is_expected.to have_selector "select#data_type" }
  it { is_expected.to have_selector "select#data_project_ids" }
end
