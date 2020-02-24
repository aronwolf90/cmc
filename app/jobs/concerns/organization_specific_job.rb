# frozen_string_literal: true

# Note: Prepend this class
module Concerns
  module OrganizationSpecificJob
    def perform(organization:, **args)
      Apartment::Tenant.switch(organization.name) do
        super(**args)
      end
    end
  end
end
