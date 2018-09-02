# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecordDay, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:records) }

  before do
    create(:organization, name: "public")
  end

  describe "with records" do
    subject { RecordDay.find_by(day: record.start_time) }

    let(:user) { create(:admin) }
    let(:record) { create(:record, user: user) }

    before { create(:record, user: user, start_time: 2.day.from_now) }

    it "return asscoaitated records" do
      expect(subject.records).to eq([record])
    end
  end

  describe "scope .ordered" do
    before do
      create(:record, start_time: 10.days.ago, end_time: 9.days.ago)
      create(:record, start_time: 8.days.ago, end_time: 7.days.ago)
    end

    it "ordered from newest day to oldest day" do
      expect(RecordDay.ordered.pluck(:day)).to eq([8.days.ago.to_date, 10.days.ago.to_date])
    end
  end
end
