# frozen_string_literal: true

class RecordsForMonthQuery < ApplicationQuery
  attr_reader :relation, :month

  def initialize(relation, month: Time.zone.now)
    @relation = relation
    @month = month
  end

  def call
    relation.where(start_time: interval)
  end

  private
    def interval
      month.at_beginning_of_month..month.at_end_of_month
    end
end
