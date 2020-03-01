class RemoveNotNullConstrainForProjectIdForProjects < ActiveRecord::Migration[5.1]
  def change
    change_column_null :board_lists, :project_id, true
  end
end
