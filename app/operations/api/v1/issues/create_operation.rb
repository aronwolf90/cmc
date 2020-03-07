# frozen_string_literal: true

module Api::V1
  module Issues
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = IssueDeserializer
      @model = Issue
      @policy = IssuePolicy
      include StandardCreateOperationConcern
    end
  end
end
