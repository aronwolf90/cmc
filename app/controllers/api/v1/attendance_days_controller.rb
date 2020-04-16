# frozen_string_literal: true

module Api
  module V1
    class AttendanceDaysController < ApiController
      serializer Api::V1::AttendanceDaySerializer

      def index
        attendance_days = AttendanceDay.from_to(
          from_date,
          from_date + 13.days
        )

        render json: serializer.new(attendance_days, {
          links: {
            first: nil,
            last: nil,
            prev: api_v1_attendance_days_path(from_date: from_date - 14.days),
            next: api_v1_attendance_days_path(from_date: from_date + 14.days),
            meta: {
              prev: from_date - 14.days,
              current: from_date,
              next: from_date + 14.days
            },
          },
          params: { current_user: current_user }
        })
      end

      private
        def from_date
          @from_date ||= (params.dig(:page, :number) || Date.current).to_date
        end
    end
  end
end
