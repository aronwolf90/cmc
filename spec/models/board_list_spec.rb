# frozen_string_literal: true

require "rails_helper"

RSpec.describe BoardList, type: :model do
  it { is_expected.to belong_to(:project) }
  it { is_expected.to have_many(:issues) }

  describe "#complexity" do
    let(:board_list) { create(:board_list) }

    before do
      create(:issue, complexity: 3, board_list: board_list)
    end

    it "returns the sum of the complexity of his tickets" do
      expect(board_list.complexity).to eq(3)
    end
  end
end
