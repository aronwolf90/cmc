# frozen_string_literal: true

module Api::V1
  module WikiPages
    class UpdateOperation < ApiOperation
      step ValidateStep.new(form: UpdateForm)
      success DeserializeStep.new(deserializer: WikiPageDeserializer)
      success UpdateStep.new
    end
  end
end
