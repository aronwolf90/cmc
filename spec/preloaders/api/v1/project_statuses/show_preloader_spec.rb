# frozen_string_literal: true

require "rails_helper"

describe Api::V1::ProjectStatuses::ShowPreloader do
  subject do
    described_class.(project_status, project_board_lists: [project_board_list])
  end

  let(:project_status) { ProjectStatus.new(id: 1)  }
  let(:project_board_list) { ProjectBoardList.new(id: 1) }

  specify do
    subject
    expect(project_status.project_board_lists).to eq([project_board_list])
  end
end
