# frozen_string_literal: true

require "rails_helper"

RSpec.describe Issues::UpdateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model,
      ordinal_number: 3
    )
  end

  let(:current_user) { create(:employee) }
  let(:model) { create(:issue, ordinal_number: 1, board_list: board_list) }
  let(:board_list) { create(:board_list) }

  before do
    create(:issue, ordinal_number: 2, board_list: board_list)
    create(:issue, ordinal_number: nil, board_list: board_list)
  end

  specify do
    expect(subject.reload.ordinal_number).to eq(3)
  end
end
