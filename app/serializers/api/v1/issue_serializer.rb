# frozen_string_literal: true

module Api
  module V1
    class IssueSerializer < ApplicationSerializer
      set_type :issues

      attributes(
        :title,
        :description,
        :complexity
      )

      belongs_to :user, serializer: UserSerializer,
        record_type: 'users'
      has_one :board_list, serializer: BoardListSerializer,
        record_type: 'board-lists'
      has_many :comments, serializer: CommentSerializer,
        record_type: 'board-lists', lazy_load_data: true

      link(:self) { |object| "/api/v1/issues/#{object.id}" }

      attribute :due_at do |object|
        object.due_at&.strftime("%d-%m-%Y %H:%M")
      end

      attribute :deadline_at do |object|
        object.deadline_at&.strftime("%d-%m-%Y %H:%M")
      end

      def self.eager_load_options
        %i[user board_list comments]
      end
    end
  end
end
