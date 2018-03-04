# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :user

  has_many :board_list_issue_relations
  has_many :comments
end
