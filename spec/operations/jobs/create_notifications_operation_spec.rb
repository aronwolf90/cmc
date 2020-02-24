# frozen_string_literal: true

require "rails_helper"

RSpec.describe Jobs::CreateNotificationsOperation do
  subject do
    described_class.call(date: Time.zone.now)
  end

  it "calls Jobs::CreateNotificationsMutation" do
    issues_due_at = [Issue.new]
    issues_deadline_at = [Issue.new]
    query_result = Jobs::CreateNotificationsQuery::Result.new(
      issues_due_at: issues_due_at,
      issues_deadline_at: issues_deadline_at
    )
    expect(Jobs::CreateNotificationsQuery)
      .to receive(:call)
      .and_return(query_result)
    expect(Jobs::CreateNotificationsMutation)
      .to receive(:call)
      .with(
        issues_due_at: issues_due_at,
        issues_deadline_at: issues_deadline_at
      )

    subject
  end
end
