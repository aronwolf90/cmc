# frozen_string_literal: true

class RecordsMonthUserProjectQuery < ApplicationQuery
  attr_private :user, :project, :month

  def initialize(user:, project:, month: Time.zone.now)
    @user = user
    @project = project
    @month = month
  end

  def call
    records = project.records.where(user: user)
    RecordsForMonthQuery.call(records, month: month)
  end
end
