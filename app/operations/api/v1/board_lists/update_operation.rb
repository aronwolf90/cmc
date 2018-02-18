# frozen_string_literal: true

module Api::V1
  module BoardLists
    class UpdateOperation < ApiOperation
      step ValidateStep.new(form: UpdateForm)
      success DeserializeStep.new(deserializer: BoardListDeserializer)
      success UpdateStep.new
    end
  end
end
