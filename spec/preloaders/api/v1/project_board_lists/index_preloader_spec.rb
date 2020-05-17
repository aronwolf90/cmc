# frozen_string_literal: true

require "rails_helper"

describe Api::V1::ProjectBoardLists::IndexPreloader do
  subject { described_class.(project_board_lists, projects: projects) }

  let(:project_board_list1) { ProjectBoardList.new(id: 1) }
  let(:project_board_list2) { ProjectBoardList.new(id: 2) }
  let(:project_board_lists) { [project_board_list1, project_board_list2] }
  let(:projects) { [project1, project2] }
  let(:project1) { Project.new(project_board_list_id: 1) }
  let(:project2) { Project.new(project_board_list_id: 2) }

  specify do
    subject
    expect(project_board_list1.projects).to eq([project1])
    expect(project_board_list2.projects).to eq([project2])
  end
end
