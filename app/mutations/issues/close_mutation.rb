# frozen_string_literal: true

module Issues
  class CloseMutation < StandardCreateMutation
    def call
      ActiveRecord::Base.transaction do
        close_board_list = model.project.board_lists.find_by(kind: :closed)
        model.update!(board_list: close_board_list)

        global_close_board_list = BoardList.where(project: nil).find_by(kind: :closed)
        model.update!(global_board_list: global_close_board_list)
      end
    end
  end
end
