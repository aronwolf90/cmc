# frozen_string_literal: true

module Api::V1
  module Comments
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = CommentDeserializer
      @model = Comment
      @policy = CommentPolicy
      include StandardCreateOperationConcern
    end
  end
end
