# frozen_string_literal: true

module GoogleCalenders
  class ExportEventOperation < ApplicationOperation
    success :organization!
    success :call_google_api
    success :mutate

  private
    def organization!(options, **)
      options[:organization] ||= Organization.current
    end

    def call_google_api(ctx, event:, organization:, **)
      google_event =
        if event.google_calender_event_id.present?
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
      ctx[:google_calender_event_id] = google_event.id
    end

    def mutate(_, event:, google_calender_event_id:, **)
      StandardUpdateMutation.(
        model: event,
        google_calender_event_id: google_calender_event_id
      )
    end
  end
end
