# frozen_string_literal: true

module Api
  module V1
    class SubscriptionsController < ApiController
      include StandartActions

      public :show

    private
      def model
        Organization.subscription
      end
    end
  end
end
