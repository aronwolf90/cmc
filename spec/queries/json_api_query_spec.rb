# frozen_string_literal: true

require "rails_helper"

RSpec.describe JsonApiQuery   do
  subject { described_class.(relation, params) }

  let(:relation) { BoardList.all }
  let(:params) { { include: ["issues"], sort: ["ordinal_number"], o: 1 } }
  let!(:board_list1) { create(:board_list, ordinal_number: 2)  }
  let!(:board_list2) { create(:board_list, ordinal_number: 1) }
  let!(:issue_board_list1) { create(:issue, board_list: board_list1) }
  let!(:issue_board_list2) { create(:issue, board_list: board_list2) }

  it "return in the specified order" do
    is_expected.to eq [board_list2, board_list1]
  end

  it "N+1 safety" do
    expect do
      board_lists = subject
      board_lists[0].issues.size
      board_lists[1].issues.size
    end.to make_database_queries(count: 2)
  end
end
