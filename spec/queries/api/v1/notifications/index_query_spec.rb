# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Notifications::IndexQuery do
  subject do
    described_class.call(more_id: more_id, per_page: per_page)
  end

  let!(:notification1) { create(:notification, id: 1) }
  let!(:notification2) { create(:notification, id: 2) }
  let!(:notification3) { create(:notification, id: 3) }

  context "when per_page is present and more_id=nil" do
    let(:more_id) { nil }
    let(:per_page) { 2 }

    it "return first n (per_page) issues" do
      expect(subject).to have_attributes(
        collection: [notification1, notification2],
        has_more: true
      )
    end
  end

  context "when issues exist after more_id" do
    let(:more_id) { 2 }
    let(:per_page) { 2 }

    it "return the issues after more_id" do
      expect(subject).to have_attributes(
        collection: [notification3],
        has_more: false
      )
    end
  end
end
