# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include PgSearch

  self.abstract_class = true

  scope :all_except, ->(id) { where.not(id: id) }
  scope :ordered, -> { order(:id) }
  pg_search_scope :search, against: %i[id]
end
