# frozen_string_literal: true

module GoogleCalenders
  class ExportEventJob < ApplicationJob
    discard_on ActiveRecord::RecordNotFound
    discard_on Signet::AuthorizationError

    def perform(organization, event_id)
      Apartment::Tenant.switch(organization.name) do
        GoogleCalenders::ExportEventOperation.(
          event: Event.unscoped.find(event_id),
          organization: organization
        )
      end
    end
  end
end
