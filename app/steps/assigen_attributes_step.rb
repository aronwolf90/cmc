# frozen_string_literal: true

class AssigenAttributesStep < ApplicationStep
  attr_reader :key

  def initialize(key: :params)
    @key = key
  end

  def call(options, model:, **args)
    model_attributes =
      [*key].reduce(options) do |local_options, local_key|
        local_options[local_key]
      end
    model.assign_attributes(model_attributes)
  end
end
