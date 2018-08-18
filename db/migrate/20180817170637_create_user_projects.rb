class CreateUserProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :user_projects do |t|
      t.references :user, null: false
      t.references :project, null: false

      t.timestamps
    end
  end
end
