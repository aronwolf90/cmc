# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :board_lists
  has_many :issues, through: :board_lists
  has_many :records, through: :issues

  alias_attribute :to_s, :name
end
