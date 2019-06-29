# frozen_string_literal: true

require "apartment/elevators/subdomain"

class ApartmentMiddleware < Apartment::Elevators::Generic
  def call(*env)
    super
  rescue ::Apartment::TenantNotFound
    [301, { "Location" => "http://#{ENV["DOMAIN"] || ENV["TEST_HOST"]}" }, ["redirect"]]
  end

  def parse_tenant_name(request)
    return if request.host.count(".") < 2
    tenant_name_candidate = request.host.split(".").first
    return if tenant_name_candidate =~ /^[0-9]+$/
    tenant_name_candidate
  end
end
