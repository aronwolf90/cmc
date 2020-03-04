# frozen_string_literal: true

module Api
  module V1
    class BoardListSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers

      attributes :name, :kind

      has_many :issues, serializer: IssueSerializer do |serializer|
        project_id = serializer.send(:instance_options).dig(:option_name, :project_id)
        issues =
          if project_id.present?
            IssuesProjectQuery.(object.issues, project_id: project_id)
          else
            object.issues
          end

        link(:self) { api_v1_board_list_issues_path(object) }
        link(:next) do
          api_v1_board_list_issues_path(object, more_id: issues.limit(15)&.last&.id) if issues.count > 15
        end
        issues.limit(15)
      end

      belongs_to :project, serializer: ProjectSerializer

      link(:self) { api_v1_board_list_path(object) }

      def self.eager_load_options
        %i[issues project]
      end
    end
  end
end
