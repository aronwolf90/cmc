# frozen_string_literal: true

module Api::V1
  class UpdateStep < ApiStep
    def call(options, model:, **args)
      model.update!(options[:deserialized_params])
    end
  end
end
