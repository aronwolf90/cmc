# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include PgSearch

  self.abstract_class = true

  scope :all_except, ->(id) { where.not(id: id) }
  scope :ordered, -> { order(:id) }
  pg_search_scope :search, against: %i[id]

  # :nocov:
  def self.seed(&block)
    # HACK
    reset_sequence_name
    super(&block)
  end
  # :nocov:
end
