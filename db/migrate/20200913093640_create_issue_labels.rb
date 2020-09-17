class CreateIssueLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :issue_labels do |t|
      t.references :issue
      t.references :label

      t.timestamps
    end
  end
end
