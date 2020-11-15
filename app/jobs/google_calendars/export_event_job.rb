# frozen_string_literal: true

module GoogleCalendars
  class ExportEventJob < ApplicationJob
    discard_on ActiveRecord::RecordNotFound
    discard_on Signet::AuthorizationError

    def perform(organization, event_id)
      Apartment::Tenant.switch(organization.name) do
        GoogleCalendars::ExportEventOperation.(
          event: Event.unscoped.find(event_id),
          organization: organization
        )
      end
    end
  end
end
