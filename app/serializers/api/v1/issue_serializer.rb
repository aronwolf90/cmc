# frozen_string_literal: true

module Api
  module V1
    class IssueSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers

      attributes :title, :description

      belongs_to :user, serializer: UserSerializer
      has_many :comments, serializer: CommentSerializer

      link(:self) { api_v1_issue_path(object) }
    end
  end
end