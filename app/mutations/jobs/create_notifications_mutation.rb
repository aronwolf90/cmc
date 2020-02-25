# frozen_string_literal: true

module Jobs
  class CreateNotificationsMutation < ApplicationMutation
    attr_reader :issues_due_at, :issues_deadline_at

    def initialize(issues_due_at:, issues_deadline_at:)
      @issues_due_at = issues_due_at
      @issues_deadline_at = issues_deadline_at
    end

    def call
      notifications = []

      issues_due_at.each do |issue|
        notifications << Notifications::CreateIssueDueAtMutation.call(issue: issue)
      end

      issues_deadline_at.each do |issue|
        notifications << Notifications::CreateIssueDeadlineAtMutation.call(issue: issue)
      end

      notifications.compact
    end

    def self.call(**args)
      new(**args).call
    end
  end
end
