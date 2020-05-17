# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ProjectBoardLists::Index::ProjectsQuery do
  subject { described_class.call([project_board_list1, project_board_list2], count: 2) }

  let(:project_status) { create(:project_status) }
  let(:project_board_list1) { create(:project_board_list, project_status: project_status) }
  let(:project_board_list2) { create(:project_board_list, project_status: project_status) }
  let!(:project1) do
    create(:project, id: 1, project_board_list_id: project_board_list1.id, ordinal_number: 1)
  end
  let!(:project2) do
    create(:project, id: 2, project_board_list_id: project_board_list1.id, ordinal_number: 2)
  end
  let!(:project3) do
    create(:project, id: 3, project_board_list_id: project_board_list1.id, ordinal_number: 3)
  end
  let!(:project4) do
    create(:project, id: 4, project_board_list_id: project_board_list2.id, ordinal_number: 1)
  end

  specify do
    expect(subject.sort_by(&:id)).to eq([project1, project2, project4])
  end
end
