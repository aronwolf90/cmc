# frozen_string_literal: true

module Api
  module V1
    class BoardListsController < ApiController
      include StandartActions

      def index
        super(BoardList)
      end

      def show
        super(board_list)
      end

      def update
        super(operation: BoardLists::UpdateOperation)
      end

      def destroy
        super(model: board_list)
      end

    private

      def board_list
        @board_list ||= BoardList.find(params[:id])
      end
    end
  end
end
