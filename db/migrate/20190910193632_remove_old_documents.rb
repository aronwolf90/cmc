class RemoveOldDocuments < ActiveRecord::Migration[5.1]
  def data
    Document.delete_all    
  end
end
