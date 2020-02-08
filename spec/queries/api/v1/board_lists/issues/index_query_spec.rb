# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BoardLists::Issues::IndexQuery do
  subject do
    described_class.call(
      board_list_id: board_list.id,
      per_page: per_page,
      more_id: more_id
    )
  end

  let(:board_list) { create(:board_list) }
  let!(:issue1) do
    create(:issue, id: 1, ordinal_number: 1, board_list: board_list)
  end
  let!(:issue2) do
    create(:issue, id: 2, ordinal_number: 2, board_list: board_list)
  end
  let!(:issue3) do
    create(:issue, id: 3, ordinal_number: 3, board_list: board_list)
  end

  context "when per_page is present and more_id=nil" do
    let(:per_page) { 2 }
    let(:more_id) { nil }

    it "return first n (per_page) issues" do
      expect(subject).to have_attributes(
        collection: [issue1, issue2],
        has_more: true
      )
    end
  end

  context "when issues exist after more_id" do
    let(:per_page) { 2 }
    let(:more_id) { 2 }

    it "return the issues after more_id" do
      expect(subject).to have_attributes(
        collection: [issue3],
        has_more: false
      )
    end
  end
end
