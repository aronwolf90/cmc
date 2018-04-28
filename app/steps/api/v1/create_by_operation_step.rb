# frozen_string_literal: true

module Api::V1
  class CreateByOperationStep < ApiStep
    attr_reader :operation

    def initialize(operation:)
      @operation = operation
    end

    def call(options, current_user:, **args)
      result = operation.(
        current_user: current_user,
        params: { data: options[:deserialized_params] }
      )

      options[:model] = result[:model]
    end
  end
end
