# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_operations"

RSpec.describe Api::V1::BoardLists::UpdateOperation do
  include_examples "standard api update operation",
                   form: Api::V1::BoardLists::UpdateForm,
                   deserializer: Api::V1::BoardListDeserializer,
                   model: BoardList.new(id: 1)
end
