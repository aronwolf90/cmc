# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecordsForMonthQuery do
  subject do
    described_class.call(
      Record.all,
      month: Time.parse("01.01.2018")
    )
  end

  let(:record1) { create(:record, end_time: 1.year.from_now) }

  before do
    create(:record,  start_time: Time.parse("01.03.2018"))
  end

  it "return overlapping records" do
    expect(subject.all).to eq [record1]
  end
end
