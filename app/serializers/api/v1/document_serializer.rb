# frozen_string_literal: true

module Api
  module V1
    class DocumentSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers

      attributes :name
      attributes :url

      belongs_to :folder, serializer: FolderSerializer

      link(:self) { api_v1_document_path(object) }

      def url
        api_v1_document_file_path(object.document_file)
      end
    end
  end
end
