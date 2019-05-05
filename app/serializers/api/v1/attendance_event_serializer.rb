# frozen_string_literal: true

module Api
  module V1
    class AttendanceEventSerializer < ApplicationSerializer
      attributes(
        :from_day,
        :to_day,
        :from_time,
        :to_time,
        :description
      )
      belongs_to :user, serializer: Api::V1::UserSerializer

      link(:self) { api_v1_attendance_event_path(object) }

      def from_time
        object&.from_time&.strftime("%H:%M")
      end

      def to_time
        object&.to_time&.strftime("%H:%M")
      end
    end
  end
end
