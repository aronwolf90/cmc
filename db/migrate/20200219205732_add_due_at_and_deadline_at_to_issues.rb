class AddDueAtAndDeadlineAtToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :due_at, :datetime
    add_column :issues, :deadline_at, :datetime
  end
end
