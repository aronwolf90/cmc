# frozen_string_literal: true

module Api
  module V1
    class FolderSerializer < ActiveModel::Serializer
      attributes :name, :root

      belongs_to :folder, serializer: FolderSerializer
      has_many :folders, serializer: FolderSerializer
      has_many :documents, serializer: DocumentSerializer

      def root
        object.root?
      end
    end
  end
end
