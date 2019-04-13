# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/users/create" do
  helper AdministrationHelper

  subject { rendered }

  let(:user) { Admin.new }
  let(:form) { Administration::Users::CreateForm.new(User.new) }

  before do
    sign_in(Admin.new)
    assign :model, form
    render
  end

  it { is_expected.to have_selector "#data_firstname" }
  it { is_expected.to have_selector "#data_lastname" }
  it { is_expected.to have_selector "#data_type" }
  it { is_expected.to have_selector "#data_password" }
  it { is_expected.to have_selector "#data_password_confirmation" }
  it { is_expected.to have_selector "input[type='submit']" }
  it { is_expected.to have_text "Cancel" }
end
