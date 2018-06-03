# frozen_string_literal: true

module Administration
  module Issues::Cell
    class Form < ApplicationCell
    private

      def board_list
        model.model.board_list
      end

      def board_lists
        @board_lists || ::BoardList.all
      end

      def cancel_path
        administration_board_path
      end
    end
  end
end
