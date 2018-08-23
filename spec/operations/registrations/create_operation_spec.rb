# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_create_operation"

RSpec.describe Registrations::CreateOperation do
  it_should_behave_like "standard create operation",
    form_class: RegistrationForm,
    mutation: Registrations::CreateMutation
end
