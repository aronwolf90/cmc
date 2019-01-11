# frozen_string_literal: true

require "rails_helper"

RSpec.describe Issues::UpdateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model,
      ordinal_number: 1
    )
  end

  let(:current_user) { create(:employee) }
  let(:model) { create(:issue, ordinal_number: 1) }

  before { create(:issue, ordinal_number: 2) }

  specify do
    expect(subject.reload.ordinal_number).to eq(1)
  end
end
