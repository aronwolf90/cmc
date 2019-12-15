# frozen_string_literal: true

module Issues
  class CreateMutation < StandardUpdateMutation
    def call
      ActiveRecord::Base.transaction do
        model.board_list&.issues&.ordered.to_a.each_with_index do |issue, index|
          issue.update!(ordinal_number: (issue.ordinal_number || index) + 1)
        end
        model.ordinal_number = 0
        super
      end
    end
  end
end
