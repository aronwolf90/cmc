# frozen_string_literal: true

class SpendedTimeCalculator < ApplicationCalculator
  pattr_initialize :records

  def call
    records.sum(&:spended_time)
  end
end
