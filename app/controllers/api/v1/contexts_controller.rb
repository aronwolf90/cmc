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
          google_calender_integrated: organization&.google_calender_id.present?,
          google_calender_authorization_url: GoogleCalenderClient.authentication_url(
            organization: organization
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
