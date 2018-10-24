# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApiController
      include StandartActions
      namespace Events
      model_class Event

      public :index, :create, :update
    end
  end
end
