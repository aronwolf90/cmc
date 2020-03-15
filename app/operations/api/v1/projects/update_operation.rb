# frozen_string_literal: true

module Api::V1
  module Projects
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = ProjectDeserializer
      @policy = ProjectPolicy
      @model = Project
      include StandardUpdateOperationConcern
    end
  end
end
