# frozen_string_literal: true

module Api
  module V1
    class BoardListSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers

      attributes :name

      has_many :issues, serializer: IssueSerializer

      belongs_to :project, serializer: ProjectSerializer

      link(:self) { api_v1_board_list_path(object) }

      def self.eager_load_options
        %i[issues project]
      end
    end
  end
end
