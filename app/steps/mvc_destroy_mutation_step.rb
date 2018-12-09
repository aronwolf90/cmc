# frozen_string_literal: true

class MvcDestroyMutationStep < ApplicationStep
  def self.call(options, current_user:, model:, **)
    mutation(model, :destroy).call(user: current_user)
  end
end
