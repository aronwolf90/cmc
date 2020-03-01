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

  alias_attribute :to_s, :title

  pg_search_scope(
    :search,
    against: %i[title description],
    using: { tsearch: { prefix: true } }
  )
end
