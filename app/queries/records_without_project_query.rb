# frozen_string_literal: true

class RecordsWithoutProjectQuery < ApplicationQuery
  pattr_initialize :records

  def call
    records.left_outer_joins(issue: { board_list: :project }).where(projects: { id: nil })
  end
end
