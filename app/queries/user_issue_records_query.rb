# frozen_string_literal: true

class UserIssueRecordsQuery < ApplicationQuery
  pattr_initialize %i[user issue]

  def call
    issue.records.where(user: user)
  end
end
