# frozen_string_literal: true

module Api
  module V1
    class BoardListsController < ApiController
      include StandartActions
      namespace BoardLists

      def index
        super(BoardList)
      end

      def show
        super
      end

      def update
        super
      end

      def destroy
        super
      end

    private

      def model
        @model ||= BoardList.find(params[:id])
      end
    end
  end
end
