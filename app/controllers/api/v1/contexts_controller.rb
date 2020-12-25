# frozen_string_literal: true

module Api
  module V1
    class ContextsController < ApiController
      include StandartActions
      update_operation Api::V1::Organizations::UpdateOperation

      def show
        organization = Organization.current

        render json: Context.new(
          current_user: current_user,
          premium: organization&.premium?,
          user_count: User.count,
          time_zone: organization&.time_zone,
          global_board: organization&.global_board,
          google_calendar_integrated: organization&.google_calendar_id.present?,
          google_calendar_authorization_url: GoogleCalendarClient.authentication_url(
            organization: organization
          ),
          month_spent_time: SpendedTimeCalculator.call(
            RecordsIntervalQuery.call(
              current_user.records,
              start_time: Time.zone.now.beginning_of_month,
              end_time: Time.zone.now.end_of_month
            )
          )
        ), include: [
          :current_user,
          "current_user.current_record",
          "current_user.current_record.issue"
        ]
      end

      def update
        update_operation.call(
          current_user: current_user,
          params: params.to_unsafe_h
        )

        head :ok
      end
    end
  end
end
