# frozen_string_literal: true

module GoogleCalendars
  class ImportEventsJob < ApplicationJob
    def perform(organization)
      Apartment::Tenant.switch(organization.name) do
        GoogleCalendars::ImportEventsOperation.(
          organization: organization
        )
      end
    end
  end
end
