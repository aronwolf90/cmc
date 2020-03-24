# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_operations"

RSpec.describe Api::V1::ProjectBoardLists::CreateOperation do
  include_examples "standard api create operation",
                   form: Api::V1::ProjectBoardLists::CreateForm,
                   deserializer: Api::V1::ProjectBoardListDeserializer,
                   mutation: ProjectBoardLists::CreateMutation
end
