# frozen_string_literal: true

class BoardList < ApplicationRecord
  has_many :issues, (lambda do
    order("ordinal_number ASC NULLS LAST")
    .order(created_at: :desc)
  end), autosave: true

  belongs_to :project

  def issue_ids=(ids)
    self.issues = Issue.where(id: ids)
  end

  def issues=(issues)
    issues.each_with_index do |issue, index|
      issue.assign_attributes(ordinal_number: index)
    end
    super(issues)
  end
end
