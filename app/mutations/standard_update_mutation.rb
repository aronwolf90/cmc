# frozen_string_literal: true

class StandardUpdateMutation < ApplicationMutation
  def call
    model.update!(attributes)
  end
end
