# frozen_string_literal: true

module Api::V1
  module ProjectBoardLists
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = ProjectBoardListDeserializer
      @policy = ProjectBoardListPolicy
      @model = ProjectBoardList
      include StandardUpdateOperationConcern
    end
  end
end
