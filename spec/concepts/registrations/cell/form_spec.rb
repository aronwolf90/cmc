# frozen_string_literal: true

require "rails_helper"

RSpec.describe Registrations::Cell::Form, type: :cell do
  controller RegistrationsController

  subject { cell(described_class, form).() }

  let(:form) do
    RegistrationForm.new(Registration.new)
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
