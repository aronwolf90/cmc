# frozen_string_literal: true

require "rails_helper"

RSpec.describe GeneralBoard, type: :model do
  let(:attributes) { { board_lists_attributes: [ { id: 1 }, { id: 2 } ] } }

  describe "#board_lists_attributes=" do
    let(:board_list_2) { build_stubbed(:board_list) }
    let(:board_list_1) { build_stubbed(:board_list) }

    before :each do
      allow(BoardList).to receive(:find).with(1).and_return(board_list_1)
      allow(BoardList).to receive(:find).with(2).and_return(board_list_2)
    end

    it "board_lists has correct order" do
      expect(described_class.new(attributes).board_lists).to eq([board_list_1, board_list_2])
    end
  end

  describe "#update!" do
    let(:board_list_1) { create(:board_list) }
    let(:board_list_2) { create(:board_list) }

    before :each do
      allow(BoardList).to receive(:find).with(1).and_return(board_list_1)
      allow(BoardList).to receive(:find).with(2).and_return(board_list_2)
    end

    it "correct ordinal_number" do
      described_class.new(attributes).update!

      expect(BoardList.order(:id).pluck(:ordinal_number)).to eq([0, 1])
    end
  end
end
