# frozen_string_literal: true

require "rails_helper"

RSpec.describe SpendedTimeIssueUserCalculator do
  subject { described_class.call(issue, user) }

  let(:user) { User.new(id: 1) }
  let(:issue) { Issue.new(records:  [record]) }
  let(:record) do
    build_stubbed(:record, user_id: user.id)
  end

  before do
    allow(SpendedTimeCalculator)
      .to receive(:call)
      .with([record])
      .and_return(record.spended_time)
  end

  it { is_expected.to eq 60.seconds }
end
