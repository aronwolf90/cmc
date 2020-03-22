# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectStatuses::UpdateMutation do
  subject do
    described_class.call(user: current_user, model: model, **attributes)
  end

  let(:current_user) { create(:admin) }
  let(:model) { create(:project_status) }
  let(:attributes) do
    {
      name: "New name",
      ordinal_number: 1
    }
  end
  let!(:project_status1) { create(:project_status, ordinal_number: 0) }
  let!(:project_status2) { create(:project_status, ordinal_number: 1) }
  let!(:project_status3) { create(:project_status, ordinal_number: 2) }

  specify do
    expect(subject.reload.name).to eq "New name"
    expect(project_status1.reload.ordinal_number).to eq(0)
    expect(model.reload.ordinal_number).to eq(1)
    expect(project_status2.reload.ordinal_number).to eq(2)
    expect(project_status3.reload.ordinal_number).to eq(3)
  end
end
