# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Records::ThisMonthSpentTimeStep do
  subject { described_class.call(options, current_user: current_user) }

  let(:current_user) { build_stubbed(:user, records: [record1, record2]) }
  let(:record1) { build_stubbed(:record, start_time: 2.hour.ago, end_time: 1.hour.ago) }
  let(:record2) { build_stubbed(:record, start_time: 3.hours.ago, end_time: 2.hours.ago) }
  let(:options) { {} }

  before { Timecop.freeze("01.01.2018 12:00:00") }
  after { Timecop.return }

  before do
    allow(RecordsIntervalQuery).to receive(:call).and_return([record1, record2])
    allow(SpentTimeCalculator).to receive(:call).and_return(7200.seconds)
    subject
  end

  it "set on options the correct spended Time" do
    expect(options["this_month_spended_time"]).to eq(7200.seconds)
  end
end
