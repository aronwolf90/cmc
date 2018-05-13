# frozen_string_literal: true

require "rails_helper"

RSpec.describe BoardList, type: :model do
  it { is_expected.to belong_to(:project) }
  it { is_expected.to have_many(:issues) }

  describe "issues order" do
    subject { create(:board_list) }

    let(:issue1) { build(:issue) }
    let(:issue2) { build(:issue) }

    before { subject.issues = [issue1, issue2] }

    it "return in the same order as setteters" do
      subject.issues.reload
      expect(subject.issues).to eq [issue1, issue2]
    end

    it "new issue is the last one" do
      new_issue = build(:issue)
      subject.issues << new_issue
      subject.issues.reload
      expect(subject.issues.last).to eq new_issue
    end
  end
end
