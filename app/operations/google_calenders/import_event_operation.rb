# frozen_string_literal: true

module GoogleCalenders
  class ImportEventOperation < ApplicationOperation
    success :authorize
    success :get_google_calender_event
    success :get_event
    step :check
    success :save_event

  private
    def authorize(ctx, organization:, **)
      ctx[:google_authorization_data] =
        GoogleCalenders::AuthorizeOperation.(organization: organization)[:google_authorization_data]
    end

    def get_google_calender_event(ctx, google_calender_event_id:, organization:, google_authorization_data:, **)
      ctx[:google_calender_event] = 
        GoogleCalenderClient.get_event(
          organization.google_calender_id,
          google_calender_event_id,
          google_authorization_data: google_authorization_data
        )
    end

    def get_event(ctx, google_calender_event_id:, **)
      ctx[:event] = Event.find_or_initialize_by(google_calender_event_id: google_calender_event_id)
    end

    def check(ctx, event:, google_calender_event:, **)
      return true if event.updated_at.nil?

      event.updated_at < google_calender_event.updated
    end

    def save_event(_, event:, google_calender_event:, **)
      event.update!(
        title: google_calender_event.summary,
        start_time: google_calender_event.start.date_time,
        end_time: google_calender_event.end.date_time,
        description: google_calender_event.description
      )
    end
  end
end
