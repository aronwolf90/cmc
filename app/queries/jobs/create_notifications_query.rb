# frozen_string_literal: true

module Jobs
  class CreateNotificationsQuery < ApplicationQuery
    class Result
      attr_reader :issues_due_at, :issues_deadline_at

      def initialize(issues_due_at: [], issues_deadline_at: [])
        @issues_due_at = issues_due_at
        @issues_deadline_at = issues_deadline_at
      end

      def ==(other_result)
        issues_due_at == other_result.issues_due_at
        issues_deadline_at == other_result.issues_deadline_at
      end
    end

    attr_reader :date

    def initialize(date:)
      @date = date.to_time
    end

    def call
      Result.new(
        issues_due_at: issues_due_at,
        issues_deadline_at: issues_deadline_at
      )
    end

  private
    def issues_due_at
      issues_due_at_to_notify_24_hours_before
        .or(issues_due_at_to_notify_30_minutes_before)
    end

    def issues_deadline_at
      issues_deadline_at_to_notify_24_hours_before
        .or(issues_deadline_at_to_notify_30_minutes_before)
    end

    def issues_due_at_to_notify_24_hours_before
      issues_to_ignore_ids = Notification
        .issue_due_at
        .where("created_at >= ?", date)
        .pluck(:issue_id)
      Issue.where.not(id: issues_to_ignore_ids)
        .where(due_at: [(date + 30.minutes)..(date + 24.hours)])
    end

    def issues_due_at_to_notify_30_minutes_before
      issues_to_ignore_ids = Notification
        .issue_due_at
        .where("created_at >= ?", date)
        .pluck(:issue_id)
      Issue.where.not(id: issues_to_ignore_ids)
        .where(due_at: [date..(date + 30.minutes)])
    end

    def issues_deadline_at_to_notify_24_hours_before
      issues_to_ignore_ids = Notification
        .issue_deadline_at
        .where("created_at >= ?", date)
        .pluck(:issue_id)
      Issue.where.not(id: issues_to_ignore_ids)
        .where(deadline_at: [(date + 30.minutes)..(date + 24.hours)])
    end

    def issues_deadline_at_to_notify_30_minutes_before
      issues_to_ignore_ids = Notification
        .issue_deadline_at
        .where("created_at >= ?", date)
        .pluck(:issue_id)
      Issue.where.not(id: issues_to_ignore_ids)
        .where(deadline_at: [date..(date + 30.minutes)])
    end
  end
end
