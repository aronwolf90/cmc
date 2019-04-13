# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/users/update" do
  helper AdministrationHelper

  subject { rendered }

  let(:form) { Administration::Users::UpdateForm.new(user) }
  let(:user) { build_stubbed(:user) }

  before do
    sign_in(Admin.new)
    assign :model, form
    render
  end

  it { is_expected.to have_selector "#data_firstname" }
  it { is_expected.to have_selector "#data_lastname" }
  it { is_expected.to have_selector "#data_telephone_number" }
  it { is_expected.to have_selector "input[type='submit']" }
  it { is_expected.to have_text "Cancel" }
end
