# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/organizations/form" do
  helper AdministrationHelper

  subject { rendered }

  let(:form) do
    Administration::OrganizationForm.new(build_stubbed(:organization))
  end

  before do
    sign_in(Admin.new)
    assign :model, form
    render
  end

  it { is_expected.to have_selector("#data_time_zone") }
end
