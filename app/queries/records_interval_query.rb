# frozen_string_literal: true

class RecordsIntervalQuery < ApplicationQuery
  pattr_initialize :relation, %i[start_time! end_time!]

  def call
    start_in_interval.or(end_in_interval)
  end

private

  def start_in_interval
    relation.where(start_time: interval)
  end

  def end_in_interval
    relation.where(end_time: interval)
  end

  def interval
    start_time..end_time
  end
end
