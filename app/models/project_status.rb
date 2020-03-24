# frozen_string_literal: true

class ProjectStatus < ApplicationRecord
  has_many :project_board_lists, -> { ordered }
  has_many :projects, through: :project_board_lists

  enum display_as: {
    list: "list",
    board: "board"
  }

  scope :ordered, -> { order(:ordinal_number, :created_at, :id)  }
end
