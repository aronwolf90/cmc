# frozen_string_literal: true

module Administration
  module Admin
    module Payments
      class IndexOperation < AdministrationOperation
        step :create_subscription

      private
        def create_subscription(options, params:, **args)
          return if params[:stripe_session_id].nil?

          organization = Organization.current

          options[:model] = Subscription.create_or_update(
            id: organization.subscription_id,
            stripe_session_id: params[:stripe_session_id],
            organization_id: organization.id,
            email: ::Admin.first.email,
            quantity: User.count
          )
        end
      end
    end
  end
end
