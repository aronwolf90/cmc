# frozen_string_literal: true

module Api
  module V1
    class BoardListsController < ApiController
      include StandartActions
      namespace BoardLists
      model_class BoardList
      serializer BoardListSerializer
      collection_query Api::V1::BoardLists::IndexQuery

      public :show, :update, :destroy

      def index
        collection = collection_query.(
          project_id: params.dig(:filter, :project_id)
        )

        render_json_api json: collection
      end
    end
  end
end
