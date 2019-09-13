# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_operations"

RSpec.describe Api::V1::Contacts::UpdateOperation do
  include_examples "standard api update operation",
                   form: Api::V1::Contacts::UpdateForm,
                   deserializer: Api::V1::ContactDeserializer,
                   model: Contact.new(id: 1)
end
