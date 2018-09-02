# frozen_string_literal: true

class Organization < ApplicationRecord
  def self.current
    Organization.find_by(name: Apartment::Tenant.current)
  end
end
