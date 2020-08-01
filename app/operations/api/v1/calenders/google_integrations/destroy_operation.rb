# frozen_string_literal: true

module Api::V1
  module Calenders
    module GoogleIntegrations
      class DestroyOperation < ApiOperation
        step Policy::Pundit(::Calenders::GoogleIntegrationPolicy, :destroy?)
        success :main_operation

      private
        def main_operation(ctx, organization:, **)
          ::Calenders::GoogleIntegrations::DestroyOperation.call(
            organization: organization
          )
        end
      end
    end
  end
end
