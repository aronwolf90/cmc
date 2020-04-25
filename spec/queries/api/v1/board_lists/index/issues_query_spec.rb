# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BoardLists::Index::IssuesQuery do
  subject { described_class.call([board_list1, board_list2], count: 2) }

  let(:board_list1) { create(:board_list) }
  let(:board_list2) { create(:board_list) }
  let!(:issue1) do
    create(:issue, id: 1, board_list_id: board_list1.id, ordinal_number: 1)
  end
  let!(:issue2) do
    create(:issue, id: 2, board_list_id: board_list1.id, ordinal_number: 2)
  end
  let!(:issue3) do
    create(:issue, id: 3, board_list_id: board_list1.id, ordinal_number: 3)
  end
  let!(:issue4) do
    create(:issue, id: 4, board_list_id: board_list2.id, ordinal_number: 1)
  end

  specify do
    expect(subject.sort_by(&:id)).to eq([issue1, issue2, issue4])
  end
end
