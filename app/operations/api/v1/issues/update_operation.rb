# frozen_string_literal: true

module Api::V1
  module Issues
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = IssueDeserializer
      include StandardUpdateOperationConcern
    end
  end
end
