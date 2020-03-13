# frozen_string_literal: true

class ProjectBoardList < ApplicationRecord
  belongs_to :project_status
  has_many :projects
end
