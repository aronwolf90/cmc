# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :board_list

  has_one :project, through: :board_list

  has_many :comments
  has_many :issues
  has_many :records

  alias_attribute :to_s, :title

  pg_search_scope :search, against: %i[title description id]
end
