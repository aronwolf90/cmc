# frozen_string_literal: true

module Api::V1
  module AttendanceEvents
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = AttendanceEventDeserializer
      @policy = AttendanceEventPolicy
      @model = AttendanceEvent
      include StandardUpdateOperationConcern
    end
  end
end
