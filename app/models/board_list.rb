# frozen_string_literal: true

class BoardList < ApplicationRecord
  acts_as_paranoid

  has_many :issues, (lambda do
    if Organization.global_board?
      order(:global_ordinal_number, created_at: :desc)
    else
      order(:ordinal_number, created_at: :desc)
    end
  end), dependent: :destroy

  belongs_to :project

  scope :ordered, -> { order(:ordinal_number, :id) }

  accepts_nested_attributes_for :issues

  enum kind: {
    open: "open",
    other: "other",
    closed: "closed"
  }
end
