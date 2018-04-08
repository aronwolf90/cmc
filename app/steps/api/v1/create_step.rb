# frozen_string_literal: true

module Api::V1
  class CreateStep < ApiStep
    attr_reader :model_class

    def initialize(model_class:)
      @model_class = model_class
    end

    def call(options, deserialized_params:, **args)
      options[:model] = model_class.create!(options[:deserialized_params])
    end
  end
end
