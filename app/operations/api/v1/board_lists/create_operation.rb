# frozen_string_literal: true

module Api::V1
  module BoardLists
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = BoardListDeserializer
      @model = BoardList
      @policy = BoardListPolicy
      include StandardCreateOperationConcern
    end
  end
end
