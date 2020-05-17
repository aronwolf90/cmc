# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ProjectStatuses::ShowQuery do
  subject do
    described_class.call(
      project_status_id: project_status.id,
      includes: includes
    )
  end

  let!(:project_status) { create(:project_status) }
  let!(:project_board_list) { create(:project_board_list, project_status: project_status) }
  let!(:project) { create(:project, project_board_list: project_board_list) }

  context "when includes in empty" do
    let(:includes) { %w[project_board_lists] }

    specify do
      expect(subject).to eq(project_status)
    end
  end
end
