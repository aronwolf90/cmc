# frozen_string_literal: true

module Api::V1
  module Comments
    class CreateOperation < ApiOperation
      step ValidateStep.new(form: CreateForm)
      success DeserializeStep.new(deserializer: CommentDeserializer)
      success CreateStep.new(model_class: Comment)
    end
  end
end
