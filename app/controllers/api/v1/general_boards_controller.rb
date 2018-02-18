# frozen_string_literal: true

module Api
  module V1
    class GeneralBoardsController < ApiController
      include StandartActions

      def show
        render json: GeneralBoard.new
      end

      def update
        super(operation: GeneralBoards::UpdateOperation, model: GeneralBoard)
      end
    end
  end
end
