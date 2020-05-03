# frozen_string_literal: true

require "rails_helper"

RSpec.describe Issue, type: :model do
  subject { build_stubbed(:issue)  }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :board_list }
  it { is_expected.to have_many :comments }
  it { is_expected.to have_many :records }
  it { is_expected.to have_many :user_issues }
  it { is_expected.to have_one :project }

  describe "#to_s" do
    it { expect(subject.to_s).to eq(subject.title) }
  end

  describe "#status" do
    context "when not due at or deadline at are not set" do
      subject { Issue.new }

      specify do
        expect(subject.status).to eq :none
      end
    end

    context "when not due at or deadline at has been reached" do
      subject { Issue.new(due_at: 1.day.from_now) }

      specify do
        expect(subject.status).to eq :none
      end
    end

    context "when due_at has been reached" do
      subject { Issue.new(due_at: 1.day.ago) }

      specify do
        expect(subject.status).to eq :warning
      end
    end

    context "when deadline_at has been reached" do
      subject { Issue.new(deadline_at: 1.day.ago) }

      specify do
        expect(subject.status).to eq :danger
      end
    end
  end
end
