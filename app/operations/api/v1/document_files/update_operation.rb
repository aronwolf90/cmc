# frozen_string_literal: true

module Api::V1
  module DocumentFiles
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = DocumentFileDeserializer
      @model = DocumentFile
      @policy = DocumentFilePolicy
      include StandardUpdateOperationConcern
    end
  end
end
