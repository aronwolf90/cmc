# frozen_string_literal: true

module Api::V1
  class CreateMutationStep < ApiStep
    pattr_initialize %i[mutation!]

    def call(options, deserialized_params:, current_user:, **args)
      options[:model] = mutation.call(attributes: deserialized_params, current_user: current_user)
    end
  end
end
