# frozen_string_literal: true

module Api::V1
  module Labels
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = LabelDeserializer
      @model = Label
      include StandardCreateOperationConcern
    end
  end
end
