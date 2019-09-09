class AddS3AttributesToDocumentFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :document_files, :s3_id, :string
    add_column :document_files, :s3_parts, :string, array: true, default: [], null: false
  end
end
