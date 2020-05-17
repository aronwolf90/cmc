# frozen_string_literal: true

module Api
  module V1
    class ProjectStatusesController < ApiController
      include StandartActions
      model_class ProjectStatus
      serializer ProjectStatusSerializer
      namespace ProjectStatuses

      public :index, :create, :update, :show, :destroy

    private
      def model
        @model ||= Api::V1::ProjectStatuses::ShowQuery.call(
          project_status_id: params[:id],
          includes: params.dig(:include).to_s.split(",")
        )
      end
    end
  end
end
