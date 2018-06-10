class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :name, null: false
      t.string :file, null: false
      t.references :folder, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
