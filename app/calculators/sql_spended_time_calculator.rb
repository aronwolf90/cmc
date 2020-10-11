# frozen_string_literal: true

class SqlSpendedTimeCalculator < ApplicationCalculator
  pattr_initialize :records

  def call
    result = records.sum("end_time - start_time")
    if result.is_a?(String)
      hours, minutes, seconds = records.sum("end_time - start_time").split(":")
      hours.to_i.hours + minutes.to_i.minutes + seconds.to_i.seconds
    else
      result
    end
  end
end
