# frozen_string_literal: true

class RecordDay < ApplicationRecord
  belongs_to :user
  has_many :records, (lambda do |record_day|
    where(start_time: record_day.day.beginning_of_day...record_day.day.end_of_day).ordered
  end), through: :user

  scope :ordered, -> { order(day: :desc) }
end
