class AddBelongsToSelectedProject < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :selected_project_id, :integer
    add_foreign_key :users, :projects, column: :selected_project_id
  end
end
