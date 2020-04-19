class AddDeletedAtToFolders < ActiveRecord::Migration[5.1]
  def change
    add_column :folders, :deleted_at, :datetime
  end
end
