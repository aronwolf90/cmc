# frozen_string_literal: true

class UserIssue < ApplicationRecord
  belongs_to :user
  belongs_to :issue
end
