# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserIssueSpendedTimeCalculator do
  subject { described_class.call(user: user, issue: issue) }

  let(:user) { build_stubbed(:user) }
  let(:issue) { build_stubbed(:issue) }
  let(:record) { build_stubbed(:record) }

  before do
    allow(UserIssueRecordsQuery)
      .to receive(:call).with(user: user, issue: issue).and_return([record])
    allow(SpendedTimeCalculator)
      .to receive(:call).with([record]).and_return(record.spended_time)
  end

  it { is_expected.to eq 60.seconds }
end
