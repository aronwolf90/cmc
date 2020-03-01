# frozen_string_literal: true

require "rails_helper"

RSpec.describe Projects::CreateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model
    )
  end

  let(:current_user) { create(:admin) }
  let(:model) { create(:project) }

  specify do
    expect { subject }.to change(Project, :count).by(1)
    expect(current_user.reload.selected_project).to eq model
    expect(BoardList.all.map(&:kind)).to eq(%w[open other closed])
  end
end
