# frozen_string_literal: true

module Api::V1
  class DeserializeStep < ApiStep
    attr_reader :deserializer

    def initialize(deserializer:)
      @deserializer = deserializer
    end

    def call(options, params:, **_args)
      options[:deserialized_params] = deserializer.call(params[:data])
      Rails.logger.debug [deserializer, options[:deserialized_params]]
    end
  end
end
