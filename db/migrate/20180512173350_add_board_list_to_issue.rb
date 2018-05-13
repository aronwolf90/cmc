class AddBoardListToIssue < ActiveRecord::Migration[5.1]
  def change
    add_reference :issues, :board_list, foreign_key: true, index: true
    add_column :issues, :ordinal_number, :integer
  end
end
