class AddOrdinalNumberToBoardList < ActiveRecord::Migration[5.1]
  def change
    add_column :board_lists, :ordinal_number, :integer
  end
end
