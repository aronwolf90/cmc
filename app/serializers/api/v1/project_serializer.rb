# frozen_string_literal: true

module Api
  module V1
    class ProjectSerializer < ApplicationSerializer
      set_type :projects

      attributes :name
      attributes :description

      belongs_to :project_status, serializer: ProjectStatusSerializer
      belongs_to :main_responsable, serializer: UserSerializer,
        record_type: 'users'
      has_one :folder, serializer: FolderSerializer,
        record_type: 'folders'
      has_one :contact, serializer: ContactSerializer,
        record_type: :contacts

      link(:self) { |object| "/api/v1/project/#{object.id}" }
    end
  end
end
