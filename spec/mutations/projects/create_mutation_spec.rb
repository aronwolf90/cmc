# frozen_string_literal: true

require "rails_helper"

RSpec.describe Projects::CreateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model,
      project_status_id: project_status.id
    )
  end

  let(:current_user) { create(:admin) }
  let(:model) { create(:project) }
  let(:project_status) { create(:project_status) }
  let!(:project_board_list) do
    create(:project_board_list, project_status: project_status)
  end
  let!(:project1) do
    create(
      :project,
      ordinal_number: 0,
      project_board_list: project_board_list
    )
  end

  specify do
    expect { subject }.to change(Project, :count).by(1)
    expect(BoardList.all.map(&:kind)).to eq(%w[open other closed])
    expect(subject.project_board_list.project_status).to eq(project_status)
    expect(subject.folder).to be_present
    expect(subject.ordinal_number).to eq 0
    expect(project1.reload.ordinal_number).to eq 1
  end
end
