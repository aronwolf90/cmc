# frozen_string_literal: true

module GoogleCalenders
  class ExportEventJob < ApplicationJob
    def perform(organization, event_id)
      Apartment::Tenant.switch(organization.name) do
        GoogleCalenders::ExportEventOperation.(
          event: Event.find(event_id),
          organization: organization
        )
      end
    end
  end
end
