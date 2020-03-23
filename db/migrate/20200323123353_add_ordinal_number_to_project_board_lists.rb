class AddOrdinalNumberToProjectBoardLists < ActiveRecord::Migration[5.1]
  def change
    add_column :project_board_lists, :ordinal_number, :integer, default: 0, null: false
  end
end
