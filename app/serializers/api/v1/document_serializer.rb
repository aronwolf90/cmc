# frozen_string_literal: true

module Api
  module V1
    class DocumentSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers

      attributes :name

      belongs_to :folder, serializer: FolderSerializer
    end
  end
end
