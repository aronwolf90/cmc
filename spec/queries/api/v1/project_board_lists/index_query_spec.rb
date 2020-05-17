# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ProjectBoardLists::IndexQuery do
  subject { described_class.call(project_status: project_status) }

  let!(:project_status) { create(:project_status) }
  let!(:project_board_list) { create(:project_board_list, project_status: project_status) }
  let!(:project) { create(:project, project_board_list: project_board_list) }

  it "return the board_list correct order for the specified project" do
    expect(subject).to eq([project_board_list])
  end
end
