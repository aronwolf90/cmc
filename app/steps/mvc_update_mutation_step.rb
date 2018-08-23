# frozen_string_literal: true

class MvcUpdateMutationStep < ApplicationStep
  def self.call(options, model:, current_user:, **)
    options["result.contract.default"].save do |hash|
      mutation(model, :update).call(
        user: current_user,
        **hash.deep_symbolize_keys
      )
    end
  end
end
