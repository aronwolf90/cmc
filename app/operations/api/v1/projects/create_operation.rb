# frozen_string_literal: true

module Api::V1
  module Projects
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = ProjectDeserializer
      @model = Project
      include StandardCreateOperationConcern
    end
  end
end
