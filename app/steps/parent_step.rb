# frozen_string_literal: true

class ParentStep < ApplicationStep
  pattr_initialize %i[model key]

  def call(options, params:, **)
    options[:parent] = model.find(params[key])
  end
end
