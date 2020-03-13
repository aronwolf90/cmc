class CreateProjectStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :project_statuses do |t|
      t.string :name, null: false
      t.boolean :initial, null: false, default: false

      t.timestamps
    end
  end
end
