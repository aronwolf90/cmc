# frozen_string_literal: true

module Api::V1
  module DocumentFiles
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = DocumentFileDeserializer
      @model = DocumentFile
      @policy = DocumentFilePolicy
      include StandardCreateOperationConcern
    end
  end
end
