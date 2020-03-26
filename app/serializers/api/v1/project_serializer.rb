# frozen_string_literal: true

module Api
  module V1
    class ProjectSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers

      attributes :name
      attributes :description

      belongs_to :project_status, serializer: ProjectStatusSerializer

      link(:self) { api_v1_project_path(object) }
    end
  end
end
