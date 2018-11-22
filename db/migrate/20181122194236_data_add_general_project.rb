class DataAddGeneralProject < ActiveRecord::Migration[5.1]
  def data
    Project.create!(name: "General project").tap do |project|
      BoardList.where(project_id: nil).update_all(project_id: project.id)
    end
  end
end
