# frozen_string_literal: true

require "rails_helper"

RSpec.describe OtherUserRecordsIntervalQuery do
  subject do
    described_class.call(
      user: user,
      start_time: record1.start_time,
      end_time: record2.end_time,
      record_id: record2.id
    )
  end

  let(:record1) { create(:record, user: user, end_time: 1.year.from_now) }
  let(:record2) { create(:record, user: user, start_time: 1.year.ago) }
  let(:user) { create(:admin) }

  before { create(:record, start_time: 2.year.from_now, end_time: 3.years.ago) }

  it "return overlapping records" do
    expect(subject.all).to eq [record1]
  end
end
