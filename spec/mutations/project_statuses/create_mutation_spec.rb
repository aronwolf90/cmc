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

  specify do
    expect(subject).to be_persisted
    expect(subject.project_board_lists.first).to be_persisted
  end
end
