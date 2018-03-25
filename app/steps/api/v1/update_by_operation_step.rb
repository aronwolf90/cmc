# frozen_string_literal: true

module Api::V1
  class UpdateByOperationStep < ApiStep
    attr_reader :operation

    def initialize(operation:)
      @operation = operation
    end

    def call(options, model:, current_user:, **args)
      operation.(
        model: model,
        current_user: current_user,
        params: options[:deserialized_params]
      )
    end
  end
end
