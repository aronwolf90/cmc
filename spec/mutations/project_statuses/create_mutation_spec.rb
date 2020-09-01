# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectStatuses::CreateMutation do
  subject do
    described_class.call(user: current_user, model: model, **attributes)
  end

  let(:current_user) { create(:admin) }
  let(:model) { ProjectStatus.new }
  let(:attributes) do
    {
      name: "New"
    }
  end

  context "when a project status is present" do
    before { create(:project_status, ordinal_number: 1) }

    specify do
      expect(subject).to be_persisted
      expect(subject.project_board_lists.first).to be_persisted
      expect(subject.ordinal_number).to eq 2
    end
  end

  context "when no project status is present" do
    specify do
      expect(subject).to be_persisted
      expect(subject.project_board_lists.first).to be_persisted
      expect(subject.ordinal_number).to eq 1
    end
  end
end
