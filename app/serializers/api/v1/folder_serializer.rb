# frozen_string_literal: true

module Api
  module V1
    class FolderSerializer < TreeSerializer
      attributes :name, :root

      belongs_to :folder, serializer: FolderSerializer
      has_many :folders, serializer: FolderSerializer
      has_many :documents, serializer: DocumentSerializer
    end
  end
end
