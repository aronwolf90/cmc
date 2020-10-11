# frozen_string_literal: true

class UserIssue < ApplicationRecord
  self.primary_keys = :user_id, :issue_id

  belongs_to :user
  belongs_to :issue

  scope :ordered, -> { order(:user_id, :issue_id) }

  def spent_time=(value)
    self[:spent_time] = "#{(value.to_i / 3600).to_s.rjust(2, '0')}:#{((value.to_i % 3600) / 60).to_s.rjust(2, '0')}:#{((value.to_i % 3600) % 60).to_s.rjust(2, '0')}"
  end

  def spent_time
    return if self[:spent_time].blank?
    return self[:spent_time] if self[:spent_time].is_a?(ActiveSupport::Duration)

    hours, minutes, seconds = self[:spent_time].split(":")
    hours.to_i.hours + minutes.to_i.minutes + seconds.to_i.seconds
  end
end
