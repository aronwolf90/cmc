class AddProjectToFolders < ActiveRecord::Migration[5.1]
  def change
    add_reference :folders, :project
  end
end
