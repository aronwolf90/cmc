class CreateBoardLists < ActiveRecord::Migration[5.1]
  def change
    create_table :board_lists do |t|
      t.string :name

      t.timestamps
    end
  end
end
