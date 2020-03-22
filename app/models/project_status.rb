# frozen_string_literal: true

class ProjectStatus < ApplicationRecord
  has_many :project_board_lists
  has_many :projects, through: :project_board_lists

  scope :ordered, -> { order(:ordinal_number, :created_at, :id)  }
end
