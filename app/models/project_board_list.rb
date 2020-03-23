# frozen_string_literal: true

class ProjectBoardList < ApplicationRecord
  belongs_to :project_status
  has_many :projects, -> { ordered }

  scope :ordered, -> { order(:ordinal_number, :created_at, :id)  }
end
