# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApiController
      include StandartActions
      namespace Events
      model_class Event
      serializer EventSerializer

      public :index, :create, :update, :destroy
    end
  end
end
