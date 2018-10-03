# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Projects::Records::ThisMonthSpentTimeStep do
  subject { described_class.call(options, parent: project) }

  let(:project) { Project.new }
  let(:record1) { Record.new(start_time: 2.hour.ago, end_time: 1.hour.ago) }
  let(:record2) { Record.new(start_time: 3.hours.ago, end_time: 2.hours.ago) }
  let(:options) { {} }

  around do |example|
    Timecop.freeze("01.01.2018 12:00:00")
    example.run
    Timecop.return
  end

  before do
    allow(project).to receive(:records).and_return([record1, record2])
  end

  before do
    allow(RecordsIntervalQuery).to receive(:call).and_return([record1, record2])
    allow(SpendedTimeCalculator).to receive(:call).and_return(7200.seconds)
    subject
  end

  it "set on options the correct spended Time" do
    expect(options[:this_month_spended_time]).to eq(7200.seconds)
  end
end
