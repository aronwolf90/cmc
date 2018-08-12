# frozen_string_literal: true

class MvcUpdateMutationStep < ApplicationStep
  pattr_initialize %i[mutation!]

  def call(options, model:, current_user:, **)
    options["result.contract.default"].save do |hash|
      mutation.call(model, attributes: hash, current_user: current_user)
    end
  end
end
