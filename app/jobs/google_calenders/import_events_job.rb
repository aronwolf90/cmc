# frozen_string_literal: true

module GoogleCalenders
  class ImportEventsJob < ApplicationJob
    def perform(organization)
      Apartment::Tenant.switch(organization.name) do
        GoogleCalenders::ImportEventsOperation.(
          organization: organization
        )
      end
    end
  end
end
