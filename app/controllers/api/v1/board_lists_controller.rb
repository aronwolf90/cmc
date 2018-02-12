module Api
  module V1
    class BoardListsController < ApiController
      def index
        render json: BoardList.all.order(:ordinal_number), include: :issues
      end

      def patch_update
        if (errors = BoardListPatchUpdateForm.perform(patch_update_params)).any?
          render json: errors
        else
          render json: BoardList.all.order(:ordinal_number), include: :issues
        end
      end

      def update
        board_list_form = BoardListForm.new(board_list_params)

        if board_list_form.save
          render json: board_list_form.model
        else
          render json: board_list_form.errors
        end
      end

      def destroy
        board_list.destroy!

        head :ok
      end

      private

      def board_list
        @board_list ||= BoardList.find(params[:id])
      end

      def patch_update_params
        params.permit(
          data: [
            :op, value:
            [
              :id,
              attributes: %i[name ordinal_number],
              relationships: [issues: [data: [:id]]]
            ]
          ]
        ).require(:data)
      end

      def board_list_params
        params.require(:board_list).permit(
          [
            :id,
            attributes: %i[name ordinal_number],
            relationships: [issues: [data: [:id]]]
          ]
        )
      end
    end
  end
end
