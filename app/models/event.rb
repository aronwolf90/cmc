# frozen_string_literal: true

class Event < ApplicationRecord
  alias_attribute :to_s, :title

  scope :ordered, -> { order(:updated_at) }
end
