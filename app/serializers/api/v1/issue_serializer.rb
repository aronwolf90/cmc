# frozen_string_literal: true

module Api
  module V1
    class IssueSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers

      attributes(
        :title,
        :description,
        :complexity,
        :my_spended_time
      )

      belongs_to :user, serializer: UserSerializer
      has_one :board_list, serializer: BoardListSerializer
      has_many :comments, serializer: CommentSerializer

      link(:self) { api_v1_issue_path(object) }

      def my_spended_time
        UserIssueSpendedTimeCalculator.(
          user: scope,
          issue: object
        ).to_i
      end
    end
  end
end
