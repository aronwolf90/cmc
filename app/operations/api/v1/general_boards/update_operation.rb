# frozen_string_literal: true

module Api::V1
  module GeneralBoards
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = GeneralBoardDeserializer
      include StandardUpdateOperationConcern
    end
  end
end
