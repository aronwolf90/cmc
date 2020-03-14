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

  it "create project status with an project_board_list" do
    expect(subject).to be_persisted
  end
end
