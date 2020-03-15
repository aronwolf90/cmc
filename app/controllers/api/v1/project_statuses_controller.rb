# frozen_string_literal: true

module Api
  module V1
    class ProjectStatusesController < ApiController
      include StandartActions
      model_class ProjectStatus
      serializer ProjectStatusSerializer
      namespace ProjectStatuses

      public :index, :create, :update, :show, :destroy
    end
  end
end
