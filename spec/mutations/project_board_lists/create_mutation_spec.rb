# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectBoardLists::CreateMutation do
  subject do
    described_class.call(user: current_user, model: model, **attributes)
  end

  let(:current_user) { create(:admin) }
  let(:model) { ProjectBoardList.new }
  let(:attributes) do
    {
      name: "New",
      project_status_id: project_status.id
    }
  end
  let(:project_status) { create(:project_status, ordinal_number: 1) }

  before do
    create(:project_board_list, ordinal_number: 1, project_status: project_status)
  end

  specify do
    expect(subject).to be_persisted
    expect(subject.ordinal_number).to eq 2
  end
end
