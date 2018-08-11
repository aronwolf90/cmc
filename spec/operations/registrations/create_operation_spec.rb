# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_create_operation"

RSpec.describe Administration::WikiPages::CreateOperation do
  it_should_behave_like "standard create operation",
    Administration::WikiPageForm,
    {
      data: {
        organization_name: "test",
        user_name: "user name",
        user_email: "test@examil.com",
        user_password: "password",
        user_confirm_password: "password"
      }
    },
    {
      data: {
        organization_name: nil,
        user_name: nil,
        user_email: nil,
        user_password: nil,
        user_confirm_password: nil
      }
    }
end
