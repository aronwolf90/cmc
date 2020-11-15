# frozen_string_literal: true

module GoogleCalendars
  class ExportEventsJob < ApplicationJob
    def perform(organization)
      Apartment::Tenant.switch(organization.name) do
        GoogleCalendars::ExportEventsOperation.(
          organization: organization
        )
      end
    end
  end
end
