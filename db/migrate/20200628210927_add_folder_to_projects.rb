class AddFolderToProjects < ActiveRecord::Migration[5.1]
  def up
    Project.find_each do |project|
      project.folder.nil?

      project.create_folder(name: project.name)
    end
  end

  def down;end
end
