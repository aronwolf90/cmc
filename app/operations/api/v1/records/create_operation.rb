# frozen_string_literal: true

module Api::V1
  module Records
    class CreateOperation < ApiOperation
      step ValidateStep.new(form: CreateForm)
      success DeserializeStep.new(deserializer: RecordDeserializer)
      success InitializeStep.new(clazz: Record)
      success AssigenAttributesStep.new(key: :deserialized_params)
      include Concerns::RecordSaveOperation
    end
  end
end
