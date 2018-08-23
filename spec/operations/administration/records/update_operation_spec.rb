# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standard_update_operation"

RSpec.describe Administration::Records::UpdateOperation do
  let(:model) { Record.new }

  it_should_behave_like "standard update operation",
    form_class: Administration::RecordForm,
    mutation: Records::UpdateMutation
end
