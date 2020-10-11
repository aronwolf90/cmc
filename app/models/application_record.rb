# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include PgSearch::Model

  self.abstract_class = true

  scope :all_except, ->(id) { where.not(id: id) }
  scope :ordered, -> { order(:id) }
  pg_search_scope :search, against: %i[id]

  def self.seed
    record = new
    yield(record)
    record.save!
  end
end
