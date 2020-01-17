# frozen_string_literal: true

module Users
  class DestroyMutation < ApplicationMutation
    def call
      ActiveRecord::Base.transaction do
        if model.records.any?
          model.update!(active: false)
        else
          model.destroy!
        end
      end
    end
  end
end
