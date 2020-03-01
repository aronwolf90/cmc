class AddKindToBoardLists < ActiveRecord::Migration[5.1]
  def change
    execute <<-SQL
      CREATE TYPE board_list_kind_enum AS ENUM (
        'open', 'other', 'closed'
      );
    SQL

    add_column :board_lists, :kind, :board_list_kind_enum
  end
end
