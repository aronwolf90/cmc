# frozen_string_literal: true

module Api::V1
  class UpdateMutationStep < ApiStep
    def self.call(options, deserialized_params:, model:, current_user:, **args)
      mutation(model, :update).call(
        user: current_user,
        **deserialized_params
      )
    end
  end
end
