# frozen_string_literal: true

require "rails_helper"

describe Administration::RecordForm do
  subject do
    described_class.new(record)
  end

  let(:record) { build_stubbed(:record, user: user) }
  let(:user) { build_stubbed(:user, current_record: nil)  }
  let(:issue) { record.issue }

  before do
    allow(User).to receive(:exists?).with(user.id).and_return(true)
    allow(User).to receive(:find).with(user.id).and_return(user)
    allow(Issue).to receive(:exists?).with(issue.id).and_return(true)
    allow(RecordsIntervalQuery).to receive(:call).and_return([])
  end

  it { expect(subject.validate(current_user: user)).to be true }
  it { expect(subject.validate(current_user: user, issue_id: nil)).to be false }
  it { expect(subject.validate(current_user: user, start_time: nil)).to be false }
  it { expect(subject.validate(current_user: user, end_time: nil)).to be true }
  it { expect(subject.validate(current_user: user, start_time: 1.day.from_now, end_time: 1.day.ago)).to eq false }
end
