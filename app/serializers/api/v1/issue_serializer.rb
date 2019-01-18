# frozen_string_literal: true

module Api
  module V1
    class IssueSerializer < ApplicationSerializer
      attributes(
        :title,
        :description,
        :complexity
      )

      belongs_to :user, serializer: UserSerializer
      has_one :board_list, serializer: BoardListSerializer
      has_many :comments, serializer: CommentSerializer

      link(:self) { api_v1_issue_path(object) }

      def self.eager_load_options
        %i[user board_list comments]
      end
    end
  end
end
