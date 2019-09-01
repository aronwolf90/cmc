# frozen_string_literal: true

module Api::V1
  module Documents
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = DocumentDeserializer
      @policy = DocumentPolicy
      @model = Document
      include StandardUpdateOperationConcern
    end
  end
end
