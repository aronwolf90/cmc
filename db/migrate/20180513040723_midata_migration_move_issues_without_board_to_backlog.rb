class MidataMigrationMoveIssuesWithoutBoardToBacklog < ActiveRecord::Migration[5.1]
  def data
    Issue.where(board_list_id: nil).update_all(board_list_id: 4)
  end
end
