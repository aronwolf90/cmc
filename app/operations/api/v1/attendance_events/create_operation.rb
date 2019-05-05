# frozen_string_literal: true

module Api::V1
  module AttendanceEvents
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = AttendanceEventDeserializer
      @model = AttendanceEvent
      @policy = AttendanceEventPolicy
      include StandardCreateOperationConcern
    end
  end
end
