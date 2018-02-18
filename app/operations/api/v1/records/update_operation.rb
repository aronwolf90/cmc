# frozen_string_literal: true

module Api::V1
  module Records
    class UpdateOperation < ApiOperation
      step ValidateStep.new(form: UpdateForm)
      success DeserializeStep.new(deserializer: RecordDeserializer)
      success UpdateStep.new
    end
  end
end
