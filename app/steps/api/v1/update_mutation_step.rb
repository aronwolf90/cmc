# frozen_string_literal: true

module Api::V1
  class UpdateMutationStep < ApiStep
    def self.call(_options, deserialized_params:, model:, current_user:, **_args)
      mutation(model, :update).call(
        user: current_user,
        **deserialized_params
      )
    end
  end
end
