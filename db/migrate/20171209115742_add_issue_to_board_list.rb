class AddIssueToBoardList < ActiveRecord::Migration[5.1]
  def change
    add_reference :issues, :board_list
  end
end
