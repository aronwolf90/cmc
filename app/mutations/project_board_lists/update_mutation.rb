# frozen_string_literal: true

module ProjectBoardLists
  class UpdateMutation < ApplicationMutation
    def call
      ActiveRecord::Base.transaction do
        model.update!(attributes)

        SortMutation.call(
          model.project_status.project_board_lists,
          sort_key: :ordinal_number,
          model: model
        )

        model
      end
    end
  end
end
