# frozen_string_literal: true

class MvcCreateMutationStep < ApplicationStep
  def self.call(options, current_user:, model:, **)
    options["result.contract.default"].save do |hash|
      mutation(model, :create).call(
        user: current_user,
        **hash.deep_symbolize_keys
      )
    end
  end
end
