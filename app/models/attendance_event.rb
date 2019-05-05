# frozen_string_literal: true

class AttendanceEvent < ApplicationRecord
  belongs_to :user

  scope :from_to, (lambda do |from, to|
    where(from_day: from..to).or(where(to_day: from..to))
  end)
end
