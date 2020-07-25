# frozen_string_literal: true

module GoogleCalenders
  class AuthorizeOperation < ApplicationOperation
    success :authorize
    success :persist

  private
    def authorize(ctx, organization:, **)
      ctx[:google_authorization_data] =
        GoogleCalenderClient.authorize!(
          google_authorization_data: organization.google_calender_authorization_data
        )
    end

    def persist(ctx, organization:, google_authorization_data:, **)
      organization.update!(google_calender_authorization_data: google_authorization_data)
    end
  end
end
