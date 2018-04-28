# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :all_except, ->(id) { where.not(id: id) }
end
