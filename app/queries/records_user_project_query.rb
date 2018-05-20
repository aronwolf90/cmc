# frozen_string_literal: true

class RecordsUserProjectQuery < ApplicationQuery
  pattr_initialize %i[user project]

  def call
    project.records.where(user: user)
  end
end
