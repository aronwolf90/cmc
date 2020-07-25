# frozen_string_literal: true

module GoogleCalenders
  class ExportEventOperation < ApplicationOperation
    success :authorize
    success :get_google_calender_event
    step :check
    success :call_google_api
    success :update_event

  private
    def authorize(ctx, organization:, **)
      ctx[:google_authorization_data] =
        GoogleCalenders::AuthorizeOperation.(organization: organization)[:google_authorization_data]
    end

    def get_google_calender_event(ctx, event:, google_authorization_data:, organization:, **)
      return if event.google_calender_event_id.nil?

      ctx[:google_calender_event] =
        GoogleCalenderClient.get_event(
          organization.google_calender_id,
          event.google_calender_event_id,
          google_authorization_data: google_authorization_data
        )
    end

    def check(ctx, event:, google_calender_event: nil, **)
      return true if google_calender_event.nil? || event.deleted?

      event.updated_at > google_calender_event.updated
    end

    def call_google_api(ctx, event:, organization:, **)
      google_event =
        if event.deleted?
          GoogleCalenderClient.delete_event(
            google_calender_id: organization.google_calender_id,
            google_calender_event_id: event.google_calender_event_id,
            google_authorization_data: organization.google_calender_authorization_data
          )
        elsif event.google_calender_event_id.present?
          GoogleCalenderClient.update_event(
            google_calender_id: organization.google_calender_id,
            google_calender_event_id: event.google_calender_event_id,
            title: event.title,
            description: event.description,
            start_time: {
              date_time: event.start_time.rfc3339
            },
            end_time: {
              date_time: event.end_time.rfc3339
            },
            google_authorization_data: organization.google_calender_authorization_data
          )
        else
          GoogleCalenderClient.create_event(
            google_calender_id: organization.google_calender_id,
            title: event.title,
            description: event.description,
            start_time: {
              date_time: event.start_time.rfc3339
            },
            end_time: {
              date_time: event.end_time.rfc3339
            },
            google_authorization_data: organization.google_calender_authorization_data
          )
        end
      ctx[:google_calender_event_id] = google_event&.id || event.google_calender_event_id
    end

    def update_event(_, event:, google_calender_event_id:, **)
      return if event.google_calender_event_id.present?

      event.update!(google_calender_event_id: google_calender_event_id)
    end
  end
end
