# frozen_string_literal: true

module Notifications
  class CreateIssueDeadlineAtMutation < ApplicationMutation
    attr_reader :issue

    def initialize(issue:)
      @issue = issue
    end

    def call
      return if issue.user.nil?

      Notification.create!(
        subject: "Deadline at of an ticket will be reached soon",
        body: "The deadline at for the issue \"#{issue}\" is at #{deadline_at}",
        issue: issue,
        user: issue.user
      )
    end

    def self.call(*args)
      new(*args).call
    end

  private
    def deadline_at
      issue.due_at&.strftime("%d-%m-%Y %H:%M")
    end
  end
end
