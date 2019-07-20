# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe RegistrationsController do
  let(:model) do
    Registration.new(organization: Organization.new(name: "test"))
  end
  let(:form) { RegistrationForm }

  include_examples "standard new action", Registrations
  include_examples "standard create action", Registrations,
                   "http://test.test.host/users/sign_in"
end
