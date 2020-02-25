# frozen_string_literal: true

# Note: Prepend this class
module Concerns
  module OrganizationSpecificJob
    def perform(organization_id:, **args)
      organization = Organization.find_by(id: organization_id)
      return if organization.nil?

      Apartment::Tenant.switch(organization.name) do
        super(**args)
      end
    end
  end
end
