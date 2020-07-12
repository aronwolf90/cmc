# frozen_string_literal: true

module Events
  class ExportJob < ApplicationJob
    def perform(organization, event_id)
      Apartment::Tenant.switch(organization.name) do
        Events::ExportOperation.(
          event: Event.find(event_id),
          organization: organization
        )
      end
    end
  end
end
