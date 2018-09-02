# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standard_update_operation"

RSpec.describe Administration::Organizations::UpdateOperation do
  let(:model) { Organization.new }

  before do
    allow(model.class).to receive(:find_by!).and_return(model)
  end

  it_should_behave_like "standard update operation",
    form_class: Administration::OrganizationForm,
    mutation: Organizations::UpdateMutation
end
