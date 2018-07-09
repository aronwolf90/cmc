# frozen_string_literal: true

class UserIssueSpendedTimeCalculator < ApplicationCalculator
  pattr_initialize %i[user issue]

  def call
    SpendedTimeCalculator.(records)
  end

private

  def records
    @records ||= UserIssueRecordsQuery.(user: user, issue: issue)
  end
end
