# frozen_string_literal: true

module Api
  module V1
    class ProjectBoardListSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers

      attributes :name
      has_many :projects, serializer: ProjectSerializer

      link(:self) { api_v1_project_board_list_path(object) }
    end
  end
end
