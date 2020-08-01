# frozen_string_literal: true

module Calenders
  module GoogleIntegrations
    class DestroyOperation < ApplicationOperation
      success :remove_google_integration

    private
      def remove_google_integration(ctx, organization:, **)
        Calenders::GoogleIntegrations::DestroyMutation.call(
          organization: organization
        )
      end
    end
  end
end
