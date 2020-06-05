# frozen_string_literal: true

module Api::V1
  class HealthChecksController < ApiController
    skip_before_action :verify_authenticity_token

    def show
      # check database connection
      Organization.any?

      head :ok
    end

    private
      def authenticate!; end
  end
end
