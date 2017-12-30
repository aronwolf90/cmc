class BoardList < ApplicationRecord
  has_many :board_list_issue_relations
  has_many :issues, -> { order('board_list_issue_relations.ordinal_number') },
           through: :board_list_issue_relations

  before_save :assigen_ordinal_number

  private

  def assigen_ordinal_number
    self.ordinal_number = BoardList.count
  end
end
