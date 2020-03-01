class AddGlobalBoardListToIssues < ActiveRecord::Migration[5.1]
  def change
    add_reference :issues, :global_board_list, foreign_key: { to_table: :board_lists }
  end
end
