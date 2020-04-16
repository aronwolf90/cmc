# frozen_string_literal: true

module Api
  module V1
    class CommentSerializer < ApplicationSerializer
      set_type :comments

      attributes :content

      belongs_to :issue, serializer: IssueSerializer,
        record_type: :issues
      belongs_to :user, serializer: UserSerializer,
        record_type: :users
    end
  end
end
