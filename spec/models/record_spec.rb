# frozen_string_literal: true

require "rails_helper"

RSpec.describe Record, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:issue) }

  describe "scope .ordered" do
    let!(:old_record) { create(:record, start_time: 3.hours.ago, end_time: 1.hour.ago) }
    let!(:new_record) { create(:record, start_time: 1.hours.ago) }

    it "return in correct order" do
      expect(Record.ordered).to eq([new_record, old_record])
    end
  end
end
