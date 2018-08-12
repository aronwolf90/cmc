# frozen_string_literal: true

class MvcCreateMutationStep < ApplicationStep
  pattr_initialize %i[mutation!]

  def call(options, current_user:, model:, **)
    options["result.contract.default"].save do |hash|
      mutation.call(
        attributes: hash.deep_symbolize_keys,
        current_user: current_user,
        model: model
      )
    end
  end
end
