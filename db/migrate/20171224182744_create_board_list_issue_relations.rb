class CreateBoardListIssueRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :board_list_issue_relations do |t|
      t.references :board_list
      t.references :issue
      t.integer :ordinal_number

      t.timestamps
    end
  end
end
