# frozen_string_literal: true

module GoogleCalenders
  class ImportEventsOperation < ApplicationOperation
    success :authorize
    success :get_google_calender_events
    success :trigger_event_importers
    success :save_sync_token

  private
    def authorize(ctx, organization:, **)
      ctx[:google_authorization_data] =
        GoogleCalenders::AuthorizeOperation.(organization: organization)[:google_authorization_data]
    end

    def get_google_calender_events(
      ctx,
      organization:,
      google_authorization_data:,
      **
    )
      ctx[:google_calender_events] =
        GoogleCalenderClient.list_events(
          organization.google_calender_id,
          google_authorization_data: google_authorization_data,
          sync_token: organization.sync_token
        )
    end

    def trigger_event_importers(ctx, organization:, google_calender_events:, **)
      google_calender_events.items.each do |google_calender_event|
        GoogleCalenders::ImportEventJob.perform_later(
          organization,
          google_calender_event.to_json
        )
      end
    end

    def save_sync_token(ctx, organization:, google_calender_events:, **)
      organization.update!(sync_token: google_calender_events.next_sync_token)
    end
  end
end
