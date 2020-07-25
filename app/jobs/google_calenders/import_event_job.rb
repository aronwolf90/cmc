# frozen_string_literal: true

module GoogleCalenders
  class ImportEventJob < ApplicationJob
    def perform(organization, google_calender_event)
      deserialized_google_calender_event =
        Google::Apis::CalendarV3::Event.from_json(google_calender_event)

      Apartment::Tenant.switch(organization.name) do
        GoogleCalenders::ImportEventOperation.(
          organization: organization,
          google_calender_event: deserialized_google_calender_event
        )
      end
    end
  end
end
