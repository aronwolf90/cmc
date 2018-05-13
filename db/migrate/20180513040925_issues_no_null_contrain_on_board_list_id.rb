class IssuesNoNullContrainOnBoardListId < ActiveRecord::Migration[5.1]
  def change
    change_column :issues, :board_list_id, :integer, null: false
  end
end
