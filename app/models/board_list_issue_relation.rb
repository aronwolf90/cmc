class BoardListIssueRelation < ApplicationRecord
  belongs_to :board_list
  belongs_to :issue

  before_save :assigen_ordinal_number

  private

  def assigen_ordinal_number
    self.ordinal_number = board_list.issues.count
  end
end
