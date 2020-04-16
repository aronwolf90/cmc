# frozen_string_literal: true

module Api
  module V1
    class UserSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers
      set_type "users"

      attribute :firstname
      attribute :lastname
      attribute :email
      attribute :type
      attribute :active
      attribute :records_count

      belongs_to :selected_project, serializer: ProjectSerializer,
        record_type: 'projects'

      has_many :issues, serializer: IssueSerializer,
        record_type: :issues
      has_one :current_record, serializer: RecordSerializer,
        record_type: :records

      link(:self) { |object| "/api/v1/user/#{object.id}" }

      def self.eager_load_options
        %i[issues current_record selected_project]
      end
    end
  end
end
