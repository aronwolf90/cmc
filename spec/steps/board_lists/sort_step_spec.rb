# frozen_string_literal: true

require "rails_helper"

RSpec.describe BoardLists::SortStep  do
  let(:board_list1) { build_stubbed(:board_list, id: 1, ordinal_number: 1) }
  let(:board_list2) { build_stubbed(:board_list, id: 2, ordinal_number: 2) }

  let(:params) { { data: ["2", "1"] } }

  before do
    allow(BoardList).to receive(:find).with("1").and_return(board_list1)
    allow(BoardList).to receive(:find).with("2").and_return(board_list2)
  end

  it "change" do
    expect(board_list1).to  receive(:update!).with(ordinal_number: 1)
    expect(board_list2).to  receive(:update!).with(ordinal_number: 0)

    subject.call(nil, params: params)
  end
end
