# frozen_string_literal: true

require "rails_helper"

RSpec.describe JsonApiQuery   do
  subject { described_class.(relation, params) }

  let(:relation) { BoardList.all }
  let(:params) { { include: ["issues"], sort: ["ordinal_number"], o: 1 } }
  let!(:board_list1) { create(:board_list, ordinal_number: 2, project: project) }
  let!(:board_list2) { create(:board_list, ordinal_number: 1, project: project) }
  let!(:project) { create(:project) }
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

  context "query present in the params" do
    let(:params) { { query: board_list1.id } }

    it "return mached entry" do
      expect(subject.size).to eq(1)
    end
  end

  context "filter is present in the params" do
    let(:params) { { filter: { id: board_list2.id } } }

    it "return mached entry" do
      expect(subject.first).to eq(board_list2)
    end
  end

  context "filter with null is present in the params" do
    let(:params) { { filter: { user_id: "null" } } }
    let(:relation) { Issue.all }

    it "return mached entry" do
      expect(subject.all.sort).to eq(relation.sort)
    end
  end

  context "filter is a range" do
    let(:params) { { filter: { ordinal_number: "1..2" } } }

    before { create(:board_list, ordinal_number: 3) }

    it "return entries for the range" do
      expect(subject.order(:ordinal_number)).to eq([board_list2, board_list1])
    end
  end
end
