# frozen_string_literal: true

module Api::V1
  class FolderDeserializer < ApiDeserializer
    attribute :name
    belongs_to :folder
  end
end
