# frozen_string_literal: true

class DestroyStep < ApplicationStep
  def self.call(_options, model:, **)
    model.destroy!
  end
end
