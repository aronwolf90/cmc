# frozen_string_literal: true

class AssigenAttributesStep < ApplicationStep
  def call(options, params:, model:, **args)
    model.assign_attributes(params)
  end
end
