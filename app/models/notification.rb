# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  enum kind: %i[issue_due_at issue_deadline_at]
end
