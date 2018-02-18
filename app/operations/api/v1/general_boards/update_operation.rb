# frozen_string_literal: true

module Api::V1
  module GeneralBoards
    class UpdateOperation < ApiOperation
      step ValidateStep.new(form: UpdateForm)
      success DeserializeStep.new(deserializer: GeneralBoardDeserializer)
      success UpdateStep.new
    end
  end
end
