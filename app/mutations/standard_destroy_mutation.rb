# frozen_string_literal: true

class StandardDestroyMutation < ApplicationMutation
  def call
    model.destroy!
  end
end
