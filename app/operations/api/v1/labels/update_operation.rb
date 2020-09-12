# frozen_string_literal: true

module Api::V1
  module Labels
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = LabelDeserializer
      @policy = LabelPolicy
      @model = Label
      include StandardUpdateOperationConcern
    end
  end
end
