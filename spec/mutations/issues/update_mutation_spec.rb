# frozen_string_literal: true

require "rails_helper"

RSpec.describe Issues::UpdateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model,
      board_list_id: params_board_list_id,
      ordinal_number: ordinal_number
    )
  end

  let(:project) { create(:project) }
  let(:board_list) { create(:board_list, project: project) }
  let(:global_board_list) { create(:board_list, project: nil) }
  let(:current_user) { create(:employee) }
  let(:params_board_list_id) { board_list.id }
  let(:model) do
    create(
      :issue,
      ordinal_number: 1,
      global_ordinal_number: 1,
      board_list: board_list,
      global_board_list: global_board_list
    )
  end
  let(:ordinal_number) { 3 }
  let!(:issue1) do
    create(
      :issue,
      ordinal_number: 2,
      global_ordinal_number: 2,
      board_list: board_list,
      global_board_list: global_board_list
    )
  end
  let!(:issue2) do
    create(
      :issue,
      ordinal_number: 3,
      global_ordinal_number: 3,
      board_list: board_list,
      global_board_list: global_board_list,
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

    let(:params_board_list_id) { global_board_list.id }

    it "set ordinal_number on project specific board" do
      expect(subject.reload.global_board_list.issues.order(:id))
        .to eq([issue1, issue2, subject])
      expect(subject.global_ordinal_number).to eq(3)
    end
  end

  context "when change board_list and global_board?==false" do
    let(:model) do
      create(:issue, ordinal_number: 1, board_list: create(:board_list))
    end

    before { allow(Organization).to receive(:global_board?).and_return false }

    specify do
      expect(subject.reload.board_list.issues.ordered)
        .to eq([issue1, issue2, subject])
      expect(subject.ordinal_number).to eq(3)
    end
  end

  context "when change board_list and global_board?=true" do
    let(:model) do
      create(:issue, global_ordinal_number: 1, global_board_list: create(:board_list))
    end
    let(:params_board_list_id) { global_board_list.id }

    before { allow(Organization).to receive(:global_board?).and_return true }

    specify do
      expect(subject.reload.global_board_list.issues.ordered)
        .to eq([issue1, issue2, subject])
      expect(subject.global_ordinal_number).to eq(3)
    end
  end
end
