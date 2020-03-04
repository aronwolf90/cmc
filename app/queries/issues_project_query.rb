# frozen_string_literal: true

class IssuesProjectQuery < ApplicationQuery
  attr_reader :project_id, :collection

  def initialize(collection, project_id:)
    @collection = collection
    @project_id = project_id
  end

  def call
    collection.joins(:project).where(
      projects: { id: project_id }
    )
  end
end
