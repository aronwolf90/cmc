# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectBoardLists::UpdateMutation do
  subject do
    described_class.call(user: current_user, model: model, **attributes)
  end

  let(:current_user) { create(:admin) }
  let(:project_status) { create(:project_status) }
  let(:model) { create(:project_board_list, project_status: project_status) }
  let(:attributes) do
    {
      name: "New name",
      ordinal_number: 1
    }
  end
  let!(:project_board_list1) do
    create(
      :project_board_list,
      ordinal_number: 0,
      project_status: project_status
    )
  end
  let!(:project_board_list2) do
    create(
      :project_board_list,
      ordinal_number: 1,
      project_status: project_status
    )
  end
  let!(:project_board_list3) do
    create(
      :project_board_list,
      ordinal_number: 2,
      project_status: project_status
    )
  end

  specify do
    expect(subject.reload.name).to eq "New name"
    expect(project_board_list1.reload.ordinal_number).to eq(0)
    expect(model.reload.ordinal_number).to eq(1)
    expect(project_board_list2.reload.ordinal_number).to eq(2)
    expect(project_board_list3.reload.ordinal_number).to eq(3)
  end
end
