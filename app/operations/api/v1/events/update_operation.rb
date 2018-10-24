# frozen_string_literal: true

module Api::V1
  module Events
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = EventDeserializer
      @policy = EventPolicy
      @model = Event
      include StandardUpdateOperationConcern
    end
  end
end
