# frozen_string_literal: true

module Api::V1
  module ProjectBoardLists
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = ProjectBoardListDeserializer
      @model = ProjectBoardList
      @policy = ProjectBoardListPolicy
      include StandardCreateOperationConcern
    end
  end
end
