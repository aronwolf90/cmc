# frozen_string_literal: true

class Organization < ApplicationRecord
  class << self
    def current
      find_by(name: Apartment::Tenant.current)
    end
  end

  alias_attribute :to_s, :name
end
