# frozen_string_literal: true

module Api::V1
  module Issues
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = IssueDeserializer
      @policy = IssuePolicy
      include StandardUpdateOperationConcern
    end
  end
end
