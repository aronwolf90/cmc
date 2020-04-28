# frozen_string_literal: true

module Api
  module V1
    class BoardListsController < ApiController
      include StandartActions
      namespace ::Api::V1::BoardLists
      model_class BoardList
      serializer BoardListSerializer
      collection_query Api::V1::BoardLists::IndexQuery

      public :show, :create, :update, :destroy

      def index
        collection = collection_query.(
          project_id: params.dig(:filter, :project_id)
        )

        render_json_api json: collection
      end

    private
      def model
        Api::V1::BoardLists::ShowQuery.(
          id: params[:id],
          project_id: params.dig(:filter, :project_id)
        )
      end
    end
  end
end
