# frozen_string_literal: true

module Api::V1
  module Records
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = RecordDeserializer
      @policy = RecordPolicy
      @model = Record
      include StandardUpdateOperationConcern
    end
  end
end
