# frozen_string_literal: true

require "rails_helper"

RSpec.describe Record, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:issue) }
  it { is_expected.to have_one(:project) }

  describe "scope .ordered" do
    let!(:old_record) { create(:record, start_time: 3.hours.ago, end_time: 1.hour.ago) }
    let!(:new_record) { create(:record, start_time: 1.hour.ago) }

    it "return in correct order" do
      expect(Record.ordered).to eq([new_record, old_record])
    end
  end

  describe "#spended_time" do
    subject { build_stubbed(:record) }

    it { expect(subject.spended_time).to eq(1 * 60) }
  end
end
