# frozen_string_literal: true

module Api
  module V1
    module Calenders
      class GoogleIntegrationsController < ApiController
        def destroy
          result = Api::V1::Calenders::GoogleIntegrations::DestroyOperation.call(
            organization: Organization.current,
            params: {},
            current_user: current_user
          )

          return head(:ok) if result.success?

          if result["result.policy.default"].failure?
            return head(:unauthorized)
          end

          head :bad_request
        end
      end
    end
  end
end
