# frozen_string_literal: true

module Api
  module V1
    class ProjectStatusSerializer < ApplicationSerializer
      set_type :'project-statuses'

      attributes(
        :name,
        :initial,
        :display_as
      )

      has_many :projects, serializer: ProjectSerializer
      has_many :project_board_lists, serializer: ProjectBoardListSerializer

      link(:self) { |object| "/api/v1/project_status/#{object.id}" }
    end
  end
end
