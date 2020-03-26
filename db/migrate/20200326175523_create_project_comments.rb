class CreateProjectComments < ActiveRecord::Migration[5.1]
  def change
    create_table :project_comments do |t|
      t.string :content, null: false
      t.belongs_to :project, null: false
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
