# frozen_string_literal: true

class BoardList < ApplicationRecord
  has_many :issues, (lambda do
    order("issues.ordinal_number ASC NULLS LAST").order(created_at: :desc)
  end)

  belongs_to :project

  accepts_nested_attributes_for :issues
end
