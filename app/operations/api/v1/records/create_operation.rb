# frozen_string_literal: true

module Api::V1
  module Records
    class CreateOperation < ApiOperation
      step ValidateStep.new(form: CreateForm)
      success DeserializeStep.new(deserializer: RecordDeserializer)
      success CreateMutationStep.new(mutation: ::Records::CreateMutation)
    end
  end
end
