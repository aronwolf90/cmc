class CreateDocumentFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :document_files do |t|
      t.string :file, null: false

      t.timestamps
    end
  end
end
