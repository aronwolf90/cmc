# frozen_string_literal: true

module Api
  module V1
    class IssueSerializer < ApplicationSerializer
      attributes(
        :title,
        :description,
        :complexity,
        :due_at,
        :deadline_at,
        :status
      )

      belongs_to :created_by, serializer: UserSerializer
      belongs_to :user, serializer: UserSerializer
      belongs_to :board_list, serializer: BoardListSerializer
      has_many :labels, serializer: LabelSerializer

      link(:self) { api_v1_issue_path(object) }

      def due_at
        object.due_at&.strftime("%d-%m-%Y %H:%M")
      end

      def deadline_at
        object.deadline_at&.strftime("%d-%m-%Y %H:%M")
      end

      def self.eager_load_options
        %i[user]
      end
    end
  end
end
