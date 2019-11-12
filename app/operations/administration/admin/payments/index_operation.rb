# frozen_string_literal: true

module Administration
  module Admin
    module Payments
      class IndexOperation < AdministrationOperation
        step :create_subscription

      private
        def create_subscription(options, params:, **args)
          return if params[:stripe_session_id].nil?

          Subscription.create(
            stripe_session_id: params[:stripe_session_id],
            organization_id: Organization.current.id,
            email: ::Admin.first.email,
            quantity: User.count
          )
        end
      end
    end
  end
end
