# frozen_string_literal: true

module Api
  module V1
    class BoardListSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers

      attributes :name, :kind

      has_many :issues, serializer: IssueSerializer do
        link(:self) { api_v1_board_list_issues_path(object) }
        link(:next) { api_v1_board_list_issues_path(object, more_id: object.issues.limit(15)&.last&.id) if object.issues.count > 15 }
        object.issues.limit(15)
      end

      belongs_to :project, serializer: ProjectSerializer

      link(:self) { api_v1_board_list_path(object) }

      def self.eager_load_options
        %i[issues project]
      end
    end
  end
end
