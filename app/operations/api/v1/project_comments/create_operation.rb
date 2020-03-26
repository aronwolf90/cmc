# frozen_string_literal: true

module Api::V1
  module ProjectComments
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = ProjectCommentDeserializer
      @model = ProjectComment
      @policy = ProjectCommentPolicy
      include StandardCreateOperationConcern
    end
  end
end
