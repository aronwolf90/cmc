# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/users/configurations/form" do
  helper AdministrationHelper

  subject { rendered }

  let(:form) { Administration::Users::ConfigurationForm.new(user) }
  let(:user) { build_stubbed(:admin)  }

  before do
    sign_in(Admin.new)
    assign :model, form
    render
  end

  it { is_expected.to have_selector "select#data_type" }
  it { is_expected.to have_selector "select#data_project_ids" }

  it { is_expected.to have_text "Destroy" }
end
