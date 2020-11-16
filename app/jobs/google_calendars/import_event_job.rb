# frozen_string_literal: true

module GoogleCalendars
  class ImportEventJob < ApplicationJob
    def perform(organization, google_calendar_event)
      deserialized_google_calendar_event =
        Google::Apis::CalendarV3::Event.from_json(google_calendar_event)

      Apartment::Tenant.switch(organization.name) do
        GoogleCalendars::ImportEventOperation.(
          organization: organization,
          google_calendar_event: deserialized_google_calendar_event
        )
      end
    end
  end
end
