# frozen_string_literal: true

module Api
  module V1
    class ProjectBoardListSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers

      attributes :name
      has_many :projects, serializer: ProjectSerializer do |serializer|
        link(:self) { api_v1_project_board_list_projects_path(object) }
        link(:next) do
          api_v1_project_board_list_projects_path(
            object, more_id: object.proejcts[-2].id) if object.projects.size > 15
        end
        object.projects[0...15]
        link(:next) do
          api_v1_project_board_list_projects_path(object, more_id: object.projects[-2].id) if object.projects.size > 15
        end
        object.projects[0...15]
      end
      belongs_to :project_status, serializer: ProjectStatusSerializer

      link(:self) { api_v1_project_board_list_path(object) }
    end
  end
end
