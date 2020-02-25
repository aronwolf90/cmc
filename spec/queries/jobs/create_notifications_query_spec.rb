# frozen_string_literal: true

require "rails_helper"

RSpec.describe Jobs::CreateNotificationsQuery do
  subject { described_class.call(date: date) }

  context "when a issue has a due_at in 24 hours and no notification exists" do
    let!(:issue) { create(:issue, due_at: "11-10-2020 00:00:00") }
    let(:date) { "10-10-2020 00:00:00" }

    it "return the issue" do
      expect(subject).to eq Jobs::CreateNotificationsQuery::Result.new(
        issues_due_at: [issue]
      )
    end
  end

  context "when a issue has a due_at in 24 hours and a notification exists" do
    let!(:issue) { create(:issue, due_at: "11-10-2020 00:00:00") }
    let(:date) { "10-10-2020 00:00:00" }

    before do
      create(
        :notification,
        created_at: "10-10-2020 23:00:00",
        issue: issue,
        user: create(:admin),
        kind: :issue_due_at
      )
    end

    it "does not return the issue" do
      expect(subject).to eq Jobs::CreateNotificationsQuery::Result.new(
        issues_due_at: []
      )
    end
  end

  context "when a issue has due_at in the past" do
    let!(:issue) { create(:issue, due_at: "09-10-2020 00:00:00") }
    let(:date) { "10-10-2020 00:00:00" }

    it "does not return the issue" do
      expect(subject).to eq Jobs::CreateNotificationsQuery::Result.new(
        issues_due_at: []
      )
    end
  end

  context "when a issue has due_at in 30 minutes" do
    let!(:issue) { create(:issue, due_at: "10-10-2020 00:30:00") }
    let(:date) { "10-10-2020 00:00:00" }

    it "does not return the issue" do
      expect(subject).to eq Jobs::CreateNotificationsQuery::Result.new(
        issues_due_at: [issue]
      )
    end
  end

  context "when a issue has due_at in 30 minutes" do
    let!(:issue) { create(:issue, due_at: "10-10-2020 00:30:00") }
    let(:date) { "10-10-2020 00:00:00" }

    before do
      create(
        :notification,
        created_at: "10-10-2020 00:30:00",
        issue: issue,
        user: create(:admin),
        kind: :issue_due_at
      )
    end

    it "does not return the issue" do
      expect(subject).to eq Jobs::CreateNotificationsQuery::Result.new(
        issues_due_at: []
      )
    end
  end

  context "when a issue has a deadline_at in 24 hours and no notification exists" do
    let!(:issue) { create(:issue, deadline_at: "11-10-2020 00:00:00") }
    let(:date) { "10-10-2020 00:00:00" }

    it "return the issue" do
      expect(subject).to eq Jobs::CreateNotificationsQuery::Result.new(
        issues_deadline_at: [issue]
      )
    end
  end

  context "when a issue has a deadline_at in 24 hours and a notification exists" do
    let!(:issue) { create(:issue, deadline_at: "11-10-2020 00:00:00") }
    let(:date) { "10-10-2020 00:00:00" }

    before do
      create(
        :notification,
        created_at: "10-10-2020 23:00:00",
        issue: issue,
        user: create(:admin),
        kind: :issue_deadline_at
      )
    end

    it "does not return the issue" do
      expect(subject).to eq Jobs::CreateNotificationsQuery::Result.new(
        issues_deadline_at: []
      )
    end
  end

  context "when a issue has deadline_at in the past" do
    let!(:issue) { create(:issue, deadline_at: "09-10-2020 00:00:00") }
    let(:date) { "10-10-2020 00:00:00" }

    it "does not return the issue" do
      expect(subject).to eq Jobs::CreateNotificationsQuery::Result.new(
        issues_deadline_at: []
      )
    end
  end

  context "when a issue has a deadline_at in 30 minutes" do
    let!(:issue) { create(:issue, deadline_at: "10-10-2020 00:30:00") }
    let(:date) { "10-10-2020 00:00:00" }

    it "return the issue" do
      expect(subject).to eq Jobs::CreateNotificationsQuery::Result.new(
        issues_deadline_at: [issue]
      )
    end
  end

  context "when a issue deadline due_at in 30 minutes" do
    let!(:issue) { create(:issue, deadline_at: "10-10-2020 00:30:00") }
    let(:date) { "10-10-2020 00:00:00" }

    before do
      create(
        :notification,
        created_at: "10-10-2020 00:30:00",
        issue: issue,
        user: create(:admin),
        kind: :issue_deadline_at
      )
    end

    it "does not return the issue" do
      expect(subject).to eq Jobs::CreateNotificationsQuery::Result.new(
        issues_deadline_at: []
      )
    end
  end

  context "when a issue has deadline_at in 30 minutes and a notification for due_at exists" do
    let!(:issue) { create(:issue, deadline_at: "10-10-2020 00:30:00") }
    let(:date) { "10-10-2020 00:00:00" }

    before do
      create(
        :notification,
        created_at: "10-10-2020 00:30:00",
        issue: issue,
        user: create(:admin),
        kind: :issue_due_at
      )
    end

    it "does not return the issue" do
      expect(subject).to eq Jobs::CreateNotificationsQuery::Result.new(
        issues_deadline_at: [issue]
      )
    end
  end

  context "when a issue has due_at in 30 minutes and a notification for deadline_at exists" do
    let!(:issue) { create(:issue, due_at: "10-10-2020 00:30:00") }
    let(:date) { "10-10-2020 00:00:00" }

    before do
      create(
        :notification,
        created_at: "10-10-2020 00:30:00",
        issue: issue,
        user: create(:admin),
        kind: :issue_deadline_at
      )
    end

    it "does not return the issue" do
      expect(subject).to eq Jobs::CreateNotificationsQuery::Result.new(
        issues_due_at: [issue]
      )
    end
  end
end
