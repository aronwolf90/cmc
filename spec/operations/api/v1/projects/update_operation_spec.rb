# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_operations"

RSpec.describe Api::V1::Records::UpdateOperation do
  include_examples "standard api update operation",
                   form: Api::V1::Records::UpdateForm,
                   model: Record.new,
                   deserializer: Api::V1::RecordDeserializer,
                   mutation: Records::UpdateMutation
end
