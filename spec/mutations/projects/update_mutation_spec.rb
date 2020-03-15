# frozen_string_literal: true

require "rails_helper"

RSpec.describe Projects::UpdateMutation do
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

  specify do
    expect(subject.project_board_list.project_status).to eq(project_status)
  end
end
