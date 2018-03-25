# frozen_string_literal: true

class SaveStep < ApplicationStep
  def call(options, model:, **args)
    model.save!
  end
end
