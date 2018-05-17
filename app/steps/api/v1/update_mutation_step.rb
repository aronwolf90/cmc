# frozen_string_literal: true

module Api::V1
  class UpdateMutationStep < ApiStep
    pattr_initialize %i[mutation!]

    def call(options, deserialized_params:, model:, current_user:, **args)
      mutation.call(model, attributes: deserialized_params, current_user: current_user)
    end
  end
end
