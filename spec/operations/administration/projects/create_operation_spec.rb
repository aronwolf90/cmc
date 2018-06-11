# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_create_operation"

RSpec.describe Administration::Projects::CreateOperation do
  it_should_behave_like "standard create operation",
    Administration::ProjectForm,
    {
      data: {
        name: "name"
      }
    },
    {
      data: {
        name: nil
      }
    }
end
