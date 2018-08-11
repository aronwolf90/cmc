# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standard_create_operation"

RSpec.describe Administration::BoardLists::CreateOperation do
  it_should_behave_like "standard create operation",
    Administration::BoardListForm,
    {
      data: {
        name: "name",
        proect_id: 1
      }
    },
    {
      data: {
        name: nil,
        proect_id: 1
      }
    }
end
