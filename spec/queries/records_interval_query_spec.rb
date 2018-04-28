# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecordsIntervalQuery do
  subject do
    described_class.call(
      Record.all,
      start_time: record1.start_time,
      end_time: record2.end_time
    )
  end

  let(:record1) { create(:record, end_time: 1.year.from_now) }
  let(:record2) { create(:record,  start_time: 1.year.ago) }

  before { create(:record, start_time: 2.year.from_now, end_time: 3.years.ago) }

  it "return overlapping records" do
    expect(subject.all).to eq [record1, record2]
  end
end
