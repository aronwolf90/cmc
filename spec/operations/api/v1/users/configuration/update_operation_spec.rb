# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standard_operations"

RSpec.describe Api::V1::Users::Configuration::UpdateOperation do
  include_examples "standard api update operation",
                   form: Api::V1::Users::Configuration::UpdateForm,
                   model: User.new,
                   deserializer: Api::V1::Users::ConfigurationDeserializer,
                   mutation: StandardUpdateMutation
end
