# frozen_string_literal: true

class SyncStep < ApplicationStep
  def call(options, **args)
    args[:"contract.default"].sync
  end
end
