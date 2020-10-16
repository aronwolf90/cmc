# frozen_string_literal: true

class Issue < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :board_list
  belongs_to :global_board_list, class_name: "BoardList"

  has_one :project, through: :board_list

  has_many :comments
  has_many :issues
  has_many :records
  has_many :user_issues
  has_many :issue_labels
  has_many :labels, through: :issue_labels

  alias_attribute :to_s, :title

  pg_search_scope(
    :search,
    against: {
      title: "A",
      description: "B"
    },
    using: {
      tsearch: { prefix: true }
    }
  )

  def status
    return :danger if deadline_at.present? && deadline_at <= Time.zone.now
    return :warning if due_at.present? && due_at <= Time.zone.now

    :none
  end
end
