# frozen_string_literal: true

require "rails_helper"

RSpec.describe Issues::UpdateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model,
      board_list_id: board_list.id,
      ordinal_number: ordinal_number
    )
  end

  let(:current_user) { create(:employee) }
  let(:model) { create(:issue, ordinal_number: 1, global_ordinal_number: 1, board_list: board_list) }
  let(:board_list) { create(:board_list) }
  let(:ordinal_number) { 3 }

  let!(:issue1) do
    create(
      :issue,
      ordinal_number: 2,
      global_ordinal_number: 2,
      board_list: board_list
    )
  end
  let!(:issue2) do
    create(
      :issue,
      ordinal_number: 3,
      global_ordinal_number: 3,
      board_list: board_list,
      created_at: 2.day.ago
    )
  end

  context "when the board_list is a project specific one"  do
    before { allow(Organization).to receive(:global_board?).and_return false }

    it "set ordinal_number on project specific board" do
      expect(subject.reload.board_list.issues.order(:id))
        .to eq([issue1, issue2, subject])
      expect(subject.ordinal_number).to eq(3)
    end
  end

  context "when the board_list is a global one"  do
    before { allow(Organization).to receive(:global_board?).and_return true }

    it "set ordinal_number on project specific board" do
      expect(subject.reload.board_list.issues.order(:id))
        .to eq([issue1, issue2, subject])
      expect(subject.global_ordinal_number).to eq(3)
    end
  end

  context "when original board_list is a other one and issue is the last one" do
    let(:model) do
      create(:issue, ordinal_number: 1, board_list: create(:board_list))
    end

    specify do
      expect(subject.reload.board_list.issues.ordered)
        .to eq([issue1, issue2, subject])
      expect(subject.ordinal_number).to eq(3)
    end
  end
end
