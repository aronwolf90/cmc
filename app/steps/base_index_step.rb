# frozen_string_literal: true

class BaseIndexStep < ApplicationStep
  def self.page(collection, page:, per: 15)
    collection.page(page || 1).per(5)
  end
end
