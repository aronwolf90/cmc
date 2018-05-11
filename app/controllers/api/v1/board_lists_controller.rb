# frozen_string_literal: true

module Api
  module V1
    class BoardListsController < ApiController
      include StandartActions

      def index
        render json: BoardList.where(filter).order(:ordinal_number), include: :issues
      end

      def update
        super(operation: BoardLists::UpdateOperation, model: board_list)
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
