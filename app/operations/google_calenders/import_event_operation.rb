# frozen_string_literal: true

module GoogleCalenders
  class ImportEventOperation < ApplicationOperation
    success :authorize
    success :get_event
    step :check
    success :save_or_delete_event

  private
    def authorize(ctx, organization:, **)
      ctx[:google_authorization_data] =
        GoogleCalenders::AuthorizeOperation
        .call(organization: organization)[:google_authorization_data]
    end

    def get_event(ctx, google_calender_event:, **)
      ctx[:event] =
        Event.find_or_initialize_by(google_calender_event_id: google_calender_event.id)
    end

    def check(ctx, event:, google_calender_event:, **)
      return true if event.updated_at.nil?
      return true if google_calender_event.status == "cancelled"

      event.updated_at < google_calender_event.updated
    end

    def save_or_delete_event(_, event:, google_calender_event:, **)
      if google_calender_event.status == "cancelled"
        event.destroy!
      else
        event.update!(
          title: google_calender_event.summary,
          start_time: google_calender_event.start.date_time,
          end_time: google_calender_event.end.date_time,
          description: google_calender_event.description
        )
      end
    end
  end
end
