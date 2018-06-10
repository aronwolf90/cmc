class CreateFolders < ActiveRecord::Migration[5.1]
  def change
    create_table :folders do |t|
      t.string :name, null: false
      t.references :folder, index: true, foreign_key: true

      t.timestamps
    end
  end
end
