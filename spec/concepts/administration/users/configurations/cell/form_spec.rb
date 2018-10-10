# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Users::Configurations::Cell::Form, type: :cell do
  controller Administration::UsersController

  subject { cell(described_class, form, current_user: user).() }

  let(:form) { Administration::Users::ConfigurationForm.new(user) }
  let(:user) { build_stubbed(:admin)  }

  it { is_expected.to have_selector "select#data_type" }
  it { is_expected.to have_selector "select#data_project_ids" }

  it { is_expected.to have_text "Destroy" }
end
