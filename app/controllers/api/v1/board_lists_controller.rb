# frozen_string_literal: true

module Api
  module V1
    class BoardListsController < ApiController
      include StandartActions
      namespace BoardLists

      public :show, :update, :destroy

      def index
        super(BoardList)
      end

    private

      def model
        @model ||= BoardList.find(params[:id])
      end
    end
  end
end
