# frozen_string_literal: true

module Api::V1
  class UpdateStep < ApiStep
    def call(_options, deserialized_params:, model:, **args)
      model.update!(deserialized_params)
    end
  end
end
