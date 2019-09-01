# frozen_string_literal: true

module Api::V1
  module Documents
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = DocumentDeserializer
      @model = Document
      @policy = DocumentPolicy
      include StandardCreateOperationConcern
    end
  end
end
