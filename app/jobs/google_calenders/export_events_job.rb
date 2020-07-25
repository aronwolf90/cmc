# frozen_string_literal: true

module GoogleCalenders
  class ExportEventsJob < ApplicationJob
    def perform(organization)
      Apartment::Tenant.switch(organization.name) do
        GoogleCalenders::ExportEventsOperation.(
          organization: organization
        )
      end
    end
  end
end
