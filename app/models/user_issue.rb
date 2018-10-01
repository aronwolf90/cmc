# frozen_string_literal: true

class UserIssue < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  scope :ordered, -> { order(:user_id, :issue_id) }
end
