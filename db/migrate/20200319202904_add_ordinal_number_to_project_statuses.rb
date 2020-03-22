class AddOrdinalNumberToProjectStatuses < ActiveRecord::Migration[5.1]
  def change
    add_column :project_statuses, :ordinal_number, :integer, null: false, default: 0
  end
end
