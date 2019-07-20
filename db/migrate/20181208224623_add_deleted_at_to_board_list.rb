# frozen_string_literal: true

class AddDeletedAtToBoardList < ActiveRecord::Migration[5.1]
  def change
    add_column :board_lists, :deleted_at, :datetime
    add_index :board_lists, :deleted_at
  end
end
