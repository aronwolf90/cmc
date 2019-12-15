# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standard_create_operation"

RSpec.describe Administration::Issues::CreateOperation do
  before do
    allow(BoardList).to receive(:find).and_return BoardList.new
  end

  it_should_behave_like "standard create operation",
    form_class: Administration::IssueForm,
    mutation: Issues::CreateMutation,
    valid_params: { board_list_id: 1, data: {} },
    invalid_params: { board_list_id: 1, data: {} }
end
