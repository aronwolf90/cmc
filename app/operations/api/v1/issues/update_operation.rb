# frozen_string_literal: true

module Api::V1
  module Issues
    class UpdateOperation < ApiOperation
      step ValidateStep.new(form: UpdateForm)
      success DeserializeStep.new(deserializer: IssueDeserializer)
      success UpdateStep.new
    end
  end
end
