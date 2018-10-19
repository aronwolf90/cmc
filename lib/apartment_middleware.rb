# frozen_string_literal: true

require "apartment/elevators/subdomain"

class ApartmentMiddleware < ::Apartment::Elevators::Subdomain
  def call(*env)
    super
  rescue ::Apartment::TenantNotFound
    [301, { "Location" => "http://cost-manager.com" }, ["redirect"]]
  end
end
