# frozen_string_literal: true

require "rails_helper"

RSpec.describe Projects::DestroyMutation do
  subject do
    described_class.(
      user: current_user,
      model: model
    )
  end

  let(:current_user) { create(:admin, selected_project: model) }
  let!(:model) { create(:project) }

  specify do
    expect { subject }.to change(Project, :count).by(-1)
    expect(current_user.reload.selected_project).to eq nil
  end

  context "when a other project exists" do
    let!(:other_project) { create(:project) }

    specify do
      expect { subject }.to change(Project, :count).by(-1)
      expect(current_user.reload.selected_project).to eq other_project
    end
  end
end
