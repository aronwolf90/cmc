# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_operations"

RSpec.describe Api::V1::ProjectStatuses::CreateOperation do
  include_examples "standard api create operation",
                   form: Api::V1::ProjectStatuses::CreateForm,
                   deserializer: Api::V1::ProjectStatusDeserializer,
                   mutation: ProjectStatuses::CreateMutation
end
