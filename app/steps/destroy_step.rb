# frozen_string_literal: true

class DestroyStep < ApplicationStep
  def call(options, model:, **)
    model.destroy!
  end
end
