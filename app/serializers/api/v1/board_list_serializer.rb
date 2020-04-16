# frozen_string_literal: true

module Api
  module V1
    class BoardListSerializer < ApplicationSerializer
      set_type :'board-lists'

      attributes :name, :kind

      has_many :issues, serializer: IssueSerializer, links: {
        self: -> (object) { "/api/v1/board_lists/#{object.id}/issues"  }
      }, record_type: 'issues'

      belongs_to :project, serializer: ProjectSerializer,
        record_type: 'projects'

      link(:self) { |object| "/api/v1/board_lists/#{object.id}" }

      def self.eager_load_options
        [:project, issues: [:comments, :user]]
      end
    end
  end
end
