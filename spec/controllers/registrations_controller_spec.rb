# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe RegistrationsController, type: :controller do
  let(:model) {
    {
      organization: Organization.new(name: "test"),
      user: User.new
    }
  }
  let(:form) { RegistrationForm }
  let(:params) { {} }

  include_examples "standart new action", Registrations
  include_examples "standart create action", Registrations,
    "http://test.test.host/users/sign_in"
end
