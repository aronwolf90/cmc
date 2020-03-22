# frozen_string_literal: true

module Api
  module V1
    class ProjectStatusSerializer < ApplicationSerializer
      attributes(
        :name,
        :initial
      )

      has_many :projects, serializer: ProjectSerializer
      has_many :project_board_lists, serializer: ProjectBoardListSerializer

      link(:self) { api_v1_project_status_path(object) }
    end
  end
end
