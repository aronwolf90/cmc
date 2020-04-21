# frozen_string_literal: true

module Api
  module V1
    class IssueSerializer < ApplicationSerializer
      attributes(
        :title,
        :description,
        :complexity,
        :due_at,
        :deadline_at
      )

      belongs_to :user, serializer: UserSerializer
      has_one :board_list, serializer: BoardListSerializer

      link(:self) { api_v1_issue_path(object) }

      def due_at
        object.due_at&.strftime("%d-%m-%Y %H:%M")
      end

      def deadline_at
        object.deadline_at&.strftime("%d-%m-%Y %H:%M")
      end

      def self.eager_load_options
        %i[user board_list]
      end
    end
  end
end
