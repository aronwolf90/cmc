# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :board_list

  has_one :record

  has_many :comments

  alias_attribute :to_s, :title
end
