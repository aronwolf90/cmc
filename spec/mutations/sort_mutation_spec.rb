# frozen_string_literal: true

require "rails_helper"

RSpec.describe SortMutation do
  subject do
    described_class.call(
      collection,
      model: model,
      sort_key: :ordinal_number
    )
  end

  let(:model) { create(:project, project_board_list: project_board_list, ordinal_number: 1) }
  let(:collection) { Project.all }
  let(:project_status) { create(:project_status) }
  let(:project_board_list) { create(:project_board_list, project_status: project_status) }
  let!(:project1) do
    create(:project, ordinal_number: 0, project_board_list: project_board_list)
  end
  let!(:project2) do
    create(:project, ordinal_number: 1, project_board_list: project_board_list)
  end
  let!(:project3) do
    create(:project, ordinal_number: 2, project_board_list: project_board_list)
  end
  let!(:sort_value) { 1 }

  it "adjust the oridnal number of the other projects with same project board list" do
    subject
    expect(project1.reload.ordinal_number).to eq(0)
    expect(model.reload.ordinal_number).to eq(1)
    expect(project2.reload.ordinal_number).to eq(2)
    expect(project3.reload.ordinal_number).to eq(3)
  end
end
