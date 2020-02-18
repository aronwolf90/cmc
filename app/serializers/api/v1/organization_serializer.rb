# frozen_string_literal: true

module Api
  module V1
    class OrganizationSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers

      attributes :name
    end
  end
end
