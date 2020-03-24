class AddDisplayAsToProjectStatuses < ActiveRecord::Migration[5.1]
  def change
    add_column :project_statuses, :display_as, :string, default: "list", null: false
  end
end
