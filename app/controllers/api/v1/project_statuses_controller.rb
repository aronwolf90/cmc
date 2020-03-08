# frozen_string_literal: true

module Api
  module V1
    class ProjectStatusesController < ApiController
      include StandartActions
      model_class ProjectStatus
      serializer ProjectStatusSerializer

      public :index, :show
    end
  end
end
