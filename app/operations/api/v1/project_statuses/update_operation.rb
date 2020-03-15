# frozen_string_literal: true

module Api::V1
  module ProjectStatuses
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = ProjectStatusDeserializer
      @policy = ProjectStatusPolicy
      @model = ProjectStatus
      include StandardUpdateOperationConcern
    end
  end
end
