# frozen_string_literal: true

class BoardList < ApplicationRecord
  acts_as_paranoid

  has_many :issues

  belongs_to :project

  scope :ordered, -> { order(:ordinal_number, :id) }

  enum kind: {
    open: "open",
    other: "other",
    closed: "closed"
  }

  def issues
    @issues ||=
      if project_id.nil?
        Issue
          .where(global_board_list_id: id)
          .order(:global_ordinal_number, created_at: :desc)
      else
        Issue
          .where(board_list_id: id)
          .order(:ordinal_number, created_at: :desc)
      end
  end
end
