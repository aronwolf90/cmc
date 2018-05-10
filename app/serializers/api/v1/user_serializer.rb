# frozen_string_literal: true

module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers

      attributes :firstname

      belongs_to :selected_project, serializer: ProjectSerializer

      has_many :issues, serializer: IssueSerializer
      has_one :current_record, serializer: RecordSerializer

      link(:self) { api_v1_user_path(object) }
    end
  end
end
