# frozen_string_literal: true

class RecordsForMonthQuery < ApplicationQuery
  attr_reader :relation, :mounth

  def initialize(relation, mounth: Time.zone.now)
    @relation = relation
    @mounth = mounth
  end

  def call
    relation.where(start_time: interval)
  end

private

  def interval
    mounth.at_beginning_of_month..mounth.at_end_of_month
  end
end
