# frozen_string_literal: true

module Api
  module V1
    class DocumentSerializer < ApplicationSerializer
      set_type :documents

      attributes :name
      attributes :url

      belongs_to :folder, serializer: FolderSerializer,
        record_type: :folders

      link(:self) { "/api/v1/documents/#{object}" }

      def url
        "/api/v1/document_files/#{object.document_file.id}"
      end
    end
  end
end
