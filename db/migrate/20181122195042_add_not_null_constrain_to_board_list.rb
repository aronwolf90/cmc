# frozen_string_literal: true

class AddNotNullConstrainToBoardList < ActiveRecord::Migration[5.1]
  def change
    change_column_null :board_lists, :project_id, false
  end
end
