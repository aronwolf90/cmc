# frozen_string_literal: true

class ProjectRecordDay < ApplicationRecord
  belongs_to :project
  has_many :records, (lambda do |record_day|
    where(start_time: record_day.day.beginning_of_day...record_day.day.end_of_day).ordered
  end), through: :project

  scope :ordered, -> { order(day: :desc) }

  def spent_time
    records.sum(&:spended_time)
  end
end
