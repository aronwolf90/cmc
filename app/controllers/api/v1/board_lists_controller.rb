# frozen_string_literal: true

module Api
  module V1
    class BoardListsController < ApiController
      include StandartActions
      namespace BoardLists
      model_class BoardList
      serializer BoardListSerializer

      public :index, :show, :update, :destroy
    end
  end
end
