class CreateProjectBoardLists < ActiveRecord::Migration[5.1]
  def change
    create_table :project_board_lists do |t|
      t.string :name
      t.references :project_status, null: false

      t.timestamps
    end
  end
end
