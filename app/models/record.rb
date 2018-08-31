# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  has_one :project, through: :issue

  scope :active, -> { where(end_time: nil) }
  scope :ordered, -> { order(start_time: :desc) }

  alias_attribute :inactive?, :end_time?

  def active?
    !inactive?
  end

  def description
    issue&.title
  end

  def calculed_end_time
    end_time || Time.zone.now
  end

  def spended_time
    (calculed_end_time.to_i - start_time.to_i).seconds
  end
end
