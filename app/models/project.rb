# frozen_string_literal: true

class Project < ApplicationRecord
  include PgSearch

  has_many :board_lists
  has_many :issues, through: :board_lists
  has_many :records, through: :issues
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :project_record_days, -> { ordered }

  alias_attribute :to_s, :name

  pg_search_scope :search, against: %i[name id]
end
