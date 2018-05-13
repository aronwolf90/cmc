class DropBoardListIssueRelation < ActiveRecord::Migration[5.1]
  def up
    drop_table :board_list_issue_relations
  end
end
