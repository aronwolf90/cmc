# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_operations"

RSpec.describe Api::V1::DocumentFiles::UpdateOperation do
  include_examples "standard api update operation",
                   form: Api::V1::DocumentFiles::UpdateForm,
                   deserializer: Api::V1::DocumentDeserializer,
                   mutation: DocumentFiles::UpdateMutation,
                   model: DocumentFile.new(id: 1)
end
