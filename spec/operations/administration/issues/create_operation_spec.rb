# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_create_operation"

RSpec.describe Administration::Issues::CreateOperation do
  let(:board_list) { build_stubbed(:board_list) }

  before { allow(BoardList).to receive(:find).and_return(board_list) }

  it_should_behave_like "standard create operation",
    Administration::IssueForm,
    {
      data: {
        title: "title",
        description: "description"
      },
      board_list_id: 1
    },
    {
      data: {
        title: nil,
        description: "description"
      },
      board_list_id: 1
    }
end
