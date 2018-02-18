# frozen_string_literal: true

module Api::V1
  module Records
    class CreateOperation < ApiOperation
      step ValidateStep.new(form: CreateForm)
      success DeserializeStep.new(deserializer: RecordDeserializer)
      success CreateStep.new(model_class: Record)
    end
  end
end
