# frozen_string_literal: true

module Administration
  class Issues::Cell::Form < Cell::Application
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
