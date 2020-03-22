# frozen_string_literal: true

require "rails_helper"

RSpec.describe Projects::UpdateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model,
      project_status_id: project_status.id,
      ordinal_number: ordinal_number
    )
  end

  let(:current_user) { create(:admin) }
  let(:model) { create(:project, project_board_list: project_board_list) }
  let(:project_status) { create(:project_status) }
  let!(:project_board_list) do
    create(:project_board_list, project_status: project_status)
  end
  let(:ordinal_number) { 0 }

  specify do
    expect(subject.project_board_list.project_status).to eq(project_status)
  end

  context "when ordinal number is passed as a parameter" do
    let!(:project1) do
      create(:project, ordinal_number: 0, project_board_list: project_board_list)
    end
    let!(:project2) do
      create(:project, ordinal_number: 1, project_board_list: project_board_list)
    end
    let!(:project3) do
      create(:project, ordinal_number: 2, project_board_list: project_board_list)
    end
    let!(:ordinal_number) { 1 }

    it "adjust the oridnal number of the other projects with same project board list" do
      subject
      expect(project1.reload.ordinal_number).to eq(0)
      expect(model.reload.ordinal_number).to eq(1)
      expect(project2.reload.ordinal_number).to eq(2)
      expect(project3.reload.ordinal_number).to eq(3)
    end
  end
end
