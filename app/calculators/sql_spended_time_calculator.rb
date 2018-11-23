# frozen_string_literal: true

class SqlSpendedTimeCalculator < ApplicationCalculator
  pattr_initialize :records

  def call
    records.sum("end_time - start_time")
  end
end
