# frozen_string_literal: true

module Api
  module V1
    class AttendanceEventSerializer < ApplicationSerializer
      set_type :'attendance-events'

      attributes(
        :from_day,
        :to_day,
        :from_time,
        :to_time,
        :description
      )
      belongs_to :user, serializer: Api::V1::UserSerializer,
        record_type: 'users'

      link(:self) { |object| "/api/v1/attendance_event/#{object.id}" }

      def from_time
        object&.from_time&.strftime("%H:%M")
      end

      def to_time
        object&.to_time&.strftime("%H:%M")
      end
    end
  end
end
