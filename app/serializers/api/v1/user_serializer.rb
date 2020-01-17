# frozen_string_literal: true

module Api
  module V1
    class UserSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers
      type "users"

      attribute :firstname
      attribute :lastname
      attribute :email
      attribute :type

      belongs_to :selected_project, serializer: ProjectSerializer

      has_many :issues, serializer: IssueSerializer
      has_one :current_record, serializer: RecordSerializer

      link(:self) { api_v1_user_path(object) }

      def self.eager_load_options
        %i[issues current_record selected_project]
      end
    end
  end
end
