# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_operations"

RSpec.describe Api::V1::Labels::CreateOperation do
  include_examples "standard api create operation",
                   form: Api::V1::Labels::CreateForm,
                   deserializer: Api::V1::LabelDeserializer
end
