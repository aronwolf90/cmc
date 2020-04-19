class DataAddFoldersToExistingProjects < ActiveRecord::Migration[5.1]
  def data
    Project.find_each do |project|
      next if project.folder.present?
      project.create_folder(name: project.name)
    end
  end
end
