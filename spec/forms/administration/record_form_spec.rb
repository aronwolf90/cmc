# frozen_string_literal: true

require "rails_helper"

describe Administration::RecordForm do
  subject { described_class.new(record) }

  let(:record) { build_stubbed(:record, user: user) }
  let(:user) { build_stubbed(:user, current_record: nil)  }
  let(:issue) { record.issue }

  before do
    allow(User).to receive(:exists?).with(user.id).and_return(true)
    allow(User).to receive(:find).with(user.id).and_return(user)
    allow(Issue).to receive(:exists?).with(issue.id).and_return(true)
    allow(RecordsIntervalQuery).to receive(:call).and_return([])
  end

  it { expect(subject.validate({})).to be true }
  it { expect(subject.validate(issue_id: nil)).to be false }
  it { expect(subject.validate(start_time: nil)).to be false }
  it { expect(subject.validate(end_time: nil)).to be true }
  it { expect(subject.validate(start_time: 1.day.from_now, end_time: 1.day.ago)).to eq false }
end
