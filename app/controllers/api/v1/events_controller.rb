# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApiController
      include StandartActions
      namespace Events
      model_class Event
      serializer EventSerializer

      per_page 400

      public :index, :create, :update

      def destroy
        ::Api::V1::Events::DestroyOperation.call(
          organization: Organization.current,
          current_user: current_user,
          params: params.to_unsafe_hash
        )

        head :ok
      end
    end
  end
end
