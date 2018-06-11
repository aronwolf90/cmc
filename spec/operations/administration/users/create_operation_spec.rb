# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_create_operation"

RSpec.describe Administration::Users::CreateOperation do
  it_should_behave_like "standard create operation",
    Administration::UserForm,
    {
      data: {
        firstname: "firstname",
        lastname: "lastname",
        email: "test@test.com",
        password: "password"
      }
    },
    {
      data: {
        firstname: nil
      }
    }
end
