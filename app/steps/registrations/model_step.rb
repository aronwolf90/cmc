# frozen_string_literal: true

module Registrations
  class ModelStep < ApplicationStep
    def self.call(options, **)
      options[:model] = {
        organization: Organization.new,
        user: Admin.new
      }
    end
  end
end
