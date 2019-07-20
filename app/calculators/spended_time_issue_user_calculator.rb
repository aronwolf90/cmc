# frozen_string_literal: true

class SpendedTimeIssueUserCalculator < ApplicationCalculator
  pattr_initialize :issue, :user

  def call
    SpendedTimeCalculator.call(issue.records.select do |record|
      record.user_id = user.id
    end)
  end
end
