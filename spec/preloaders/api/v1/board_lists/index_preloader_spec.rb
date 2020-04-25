# frozen_string_literal: true

require "rails_helper"

describe Api::V1::BoardLists::IndexPreloader do
  subject { described_class.(board_lists, issues: issues) }

  let(:board_list1) { BoardList.new(id: 1) }
  let(:board_list2) { BoardList.new(id: 2) }
  let(:board_lists) { [board_list1, board_list2] }
  let(:issues) { [issue1, issue2] }

  context "when board list are project specific" do
    let(:issue1) { Issue.new(board_list_id: 1) }
    let(:issue2) { Issue.new(board_list_id: 2) }

    specify do
      subject
      expect(board_list1.issues).to eq([issue1])
      expect(board_list2.issues).to eq([issue2])
    end
  end

  context "when board list are global" do
    let(:issue1) { Issue.new(global_board_list_id: 1) }
    let(:issue2) { Issue.new(global_board_list_id: 2) }

    specify do
      subject
      expect(board_list1.issues).to eq([issue1])
      expect(board_list2.issues).to eq([issue2])
    end
  end
end
