# frozen_string_literal: true

module Api
  module V1
    class FolderSerializer < TreeSerializer
      attributes :name, :root

      belongs_to :folder, serializer: FolderSerializer
      has_many :folders, serializer: FolderSerializer
      has_many :documents, serializer: DocumentSerializer

      link(:self) { api_v1_folder_path(object) }
    end
  end
end
