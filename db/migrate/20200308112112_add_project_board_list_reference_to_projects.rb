class AddProjectBoardListReferenceToProjects < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :project_board_list
  end
end
