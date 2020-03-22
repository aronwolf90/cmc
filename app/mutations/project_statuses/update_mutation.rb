# frozen_string_literal: true

module ProjectStatuses
  class UpdateMutation < ApplicationMutation
    def call
      ActiveRecord::Base.transaction do
        model.update!(attributes)

        SortMutation.call(
          ProjectStatus.all,
          sort_key: :ordinal_number,
          model: model
        )

        model
      end
    end
  end
end
