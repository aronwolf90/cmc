class RemoveBoardListIdFromIssue < ActiveRecord::Migration[5.1]
  def change
    remove_reference :issues, :board_list
  end
end
