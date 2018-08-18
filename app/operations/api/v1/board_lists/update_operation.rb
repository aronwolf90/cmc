# frozen_string_literal: true

module Api::V1
  module BoardLists
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = BoardListDeserializer
      @policy = BoardListPolicy
      include StandardUpdateOperationConcern
    end
  end
end
