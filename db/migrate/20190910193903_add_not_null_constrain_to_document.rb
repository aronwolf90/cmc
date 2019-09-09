class AddNotNullConstrainToDocument < ActiveRecord::Migration[5.1]
  def change
    change_column_null :documents, :document_file_id, false
  end
end
