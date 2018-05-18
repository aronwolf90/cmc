# frozen_string_literal: true

class CreateMutationStep < ApplicationStep
  pattr_initialize %i[mutation!]

  def call(options, current_user:, **args)
    options["result.contract.default"].save do |hash|
      options[:model] = mutation.call(attributes: hash, current_user: current_user)
    end
  end
end
