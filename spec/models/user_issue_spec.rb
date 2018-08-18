# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserIssue, type: :model do
  context "issue user and record are present" do
    let(:issue) { create(:issue) }
    let(:user) { create(:admin) }
    let!(:record) { create(:record, user: user, issue: issue) }

    describe "#amount_time" do
      subject { UserIssue.first.spent_time }

      it { is_expected.to eq 60.seconds }
    end

    describe "#issue" do
      subject { UserIssue.first.issue }

      it { is_expected.to eq issue }
    end

    describe "#user" do
      subject { UserIssue.first.user }

      it { is_expected.to eq user }
    end

    describe "#start_time" do
      subject { UserIssue.first.start_time }

      it { is_expected.to eq record.start_time  }
    end
  end
end
