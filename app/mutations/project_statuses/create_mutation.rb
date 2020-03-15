# frozen_string_literal: true

module ProjectStatuses
  class CreateMutation < ApplicationMutation
    def call
      ActiveRecord::Base.transaction do
        model.update!(attributes)
        model.project_board_lists.create(name: "Default")
        model
      end
    end
  end
end
