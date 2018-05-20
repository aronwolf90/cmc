# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  scope :active, -> { where(end_time: nil) }
  scope :ordered, -> { order(start_time: :desc) }

  alias_attribute :inactive?, :end_time?

  def active?
    !inactive?
  end

  def description
    issue&.title
  end
end
