# frozen_string_literal: true

class ParentAsModelStep < ApplicationStep
  pattr_initialize %i[model key]

  def call(options, params:, **)
    options[:model] = model.find(params[key])
  end
end
