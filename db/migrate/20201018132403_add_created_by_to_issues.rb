class AddCreatedByToIssues < ActiveRecord::Migration[5.1]
  def change
    add_reference :issues, :created_by, foreign_key: { to_table: :users }
  end
end
