class BoardListIssueRelation < ApplicationRecord
  belongs_to :board_list
  belongs_to :issue
end

class Issue < ApplicationRecord
  has_one :board_list_issue_relation
end

class DataMigrationMoveIssuesDirectlyToBoardLists < ActiveRecord::Migration[5.1]
  def data
    Issue.joins(:board_list_issue_relation).find_each do |issue|
      issue.update!(board_list: issue.board_list_issue_relation.board_list)
    end
  end
end
