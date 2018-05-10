# frozen_string_literal: true

module Api::V1
  module Users
    class UpdateOperation < ApiOperation
      step ValidateStep.new(form: UpdateForm)
      success DeserializeStep.new(deserializer: UserDeserializer)
      success UpdateStep.new
    end
  end
end
