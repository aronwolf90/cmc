class AddProjectReferenceBoardLists < ActiveRecord::Migration[5.1]
  def change
    add_reference :board_lists, :project, foreign_key: true, index: true
  end
end
