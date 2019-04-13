# frozen_string_literal: true

require "rails_helper"

RSpec.describe "registrations/form" do
  subject { rendered }

  let(:form) { RegistrationForm.new(Registration.new) }

  subject { rendered }

  before do
    sign_in(Admin.new)
    assign(:model, form)
    render
  end

  it { is_expected.to have_selector("#data_name") }
  it { is_expected.to have_selector("#data_time_zone") }
  it { is_expected.to have_selector("#data_firstname") }
  it { is_expected.to have_selector("#data_lastname") }
  it { is_expected.to have_selector("#data_email") }
  it { is_expected.to have_selector("#data_password") }
  it { is_expected.to have_selector("#data_confirmation_password") }
  it { is_expected.to have_selector("input[type='submit']") }
end
