class AddCreateDocumentFileToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_reference :documents, :document_file
    remove_column :documents, :file, :string
    change_column_null :documents, :document_file_id, null: false
  end
end
