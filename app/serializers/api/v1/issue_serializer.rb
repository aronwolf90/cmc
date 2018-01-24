module Api
  module V1
    class IssueSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers

      attributes :title, :description

      belongs_to :user

      has_many :comments

      link(:self) { api_v1_issue_path(object) }
    end
  end
end
