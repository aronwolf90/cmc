# frozen_string_literal: true

module Api::V1
  class DocumentDeserializer < ApiDeserializer
    attribute :name
    attribute :document_file_id
    belongs_to :folder
  end
end
