# frozen_string_literal: true

module Api::V1
  module ProjectStatuses
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = ProjectStatusDeserializer
      @model = ProjectStatus
      @policy = ProjectStatusPolicy
      include StandardCreateOperationConcern
    end
  end
end
