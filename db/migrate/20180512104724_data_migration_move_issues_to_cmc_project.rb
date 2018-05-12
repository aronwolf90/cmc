class DataMigrationMoveIssuesToCmcProject < ActiveRecord::Migration[5.1]
  def data
    return if Project.find_by(name: "CMC: Cost managment control").nil?
    Issue.where.not(id: [4, 5, 6]).find_each do |issue|
      issue.update!(board_list: board_list_id)
    end
  end

private

  def board_list_id
    @board_list ||= BoardList.find_by(name: "in development", project_id: 1)
  end
end
