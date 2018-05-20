# frozen_string_literal: true

class SpentTimeCalculator < ApplicationCalculator
  pattr_initialize :records

  def call
    miliseconds = records.inject(0) do |sum, record|
      sum += record_time(record)
    end
    miliseconds.to_i.seconds
  end

private

  def record_time(record)
    end_time = record.end_time || Time.zone.now
    end_time - record.start_time
  end
end
