class IssueOnDeleteNullify < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :records, :issues
    add_foreign_key :records, :issues, on_delete: :nullify
  end
end
