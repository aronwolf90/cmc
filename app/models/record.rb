# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  scope :active, -> { where(end_time: nil) }

  alias_attribute :inactive?, :end_time?

  def active?
    !inactive?
  end
end
