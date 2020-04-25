# frozen_string_literal: true

module Api
  module V1
    class BoardListSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers

      attributes :name, :kind

      has_many :issues, serializer: IssueSerializer do |serializer|
        link(:self) { api_v1_board_list_issues_path(object) }
        link(:next) do
          api_v1_board_list_issues_path(object, more_id: object.issues[-2].id) if object.issues.size > 15
        end
        object.issues[0...15]
      end

      belongs_to :project, serializer: ProjectSerializer

      link(:self) { api_v1_board_list_path(object) }

      def self.eager_load_options
        %i[project]
      end
    end
  end
end
