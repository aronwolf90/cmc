# frozen_string_literal: true

module ProjectBoardLists
  class CreateMutation < ApplicationMutation
    def call
      ActiveRecord::Base.transaction do
        model.assign_attributes(attributes)
        model.ordinal_number = ordinal_number
        model.save!
        model
      end
    end

  private
    def ordinal_number
      model.project_status.project_board_lists.maximum(:ordinal_number) + 1
    end
  end
end
