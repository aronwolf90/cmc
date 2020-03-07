class AddDatabaseConstrainsForGlobalBoard < ActiveRecord::Migration[5.1]
  def change
    change_column_null :issues, :ordinal_number, false
    change_column_null :issues, :global_ordinal_number, false
    change_column_null :issues, :board_list_id, false
    change_column_null :board_lists, :kind, false
  end
end
