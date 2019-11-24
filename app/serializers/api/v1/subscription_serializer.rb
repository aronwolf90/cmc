# frozen_string_literal: true

module Api
  module V1
    class SubscriptionSerializer < TreeSerializer
      attributes :iban_last4

      def id
        "subscription"
      end
    end
  end
end
