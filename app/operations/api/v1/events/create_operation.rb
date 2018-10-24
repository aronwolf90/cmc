# frozen_string_literal: true

module Api::V1
  module Events
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = EventDeserializer
      @model = Event
      @policy = EventPolicy
      include StandardCreateOperationConcern
    end
  end
end
