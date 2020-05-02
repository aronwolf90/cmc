# frozen_string_literal: true

module Api
  module V1
    class ProjectSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers

      attributes :name
      attributes :description

      belongs_to :project_status, serializer: ProjectStatusSerializer
      belongs_to :main_responsable, serializer: UserSerializer
      has_one :folder, serializer: FolderSerializer do
        if object.folder.present?
          link(:self) { api_v1_folder_path(object.folder) }
        end
      end
      has_one :contact, serializer: ContactSerializer

      link(:self) { api_v1_project_path(object) }
    end
  end
end
