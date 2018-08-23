# frozen_string_literal: true

module Api::V1
  module WikiPages
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = WikiPageDeserializer
      @policy = WikiPagePolicy
      @model = WikiPage
      include StandardUpdateOperationConcern
    end
  end
end
