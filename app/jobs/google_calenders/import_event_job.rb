# frozen_string_literal: true

module GoogleCalenders
  class ImportEventJob < ApplicationJob
    def perform(organization, google_calender_event_id:)
      Apartment::Tenant.switch(organization.name) do
        GoogleCalenders::ImportEventOperation.(
          organization: organization, 
          google_calender_event_id: google_calender_event_id
        )
      end
    end
  end
end
