# frozen_string_literal: true

module Issues
  class UpdateMutation < StandardUpdateMutation
    def call
      ActiveRecord::Base.transaction do
        super

        return if ordinal_number.nil?

        issues_after_model.each_with_index do |issue, index|
          issue.update!(ordinal_number: index + ordinal_number)
        end
      end
    end

  private

    def issues_after_model
      model.board_list.issues.select do |issue|
        issue.ordinal_number > ordinal_number
      end
    end

    def ordinal_number
      attributes[:ordinal_number]
    end
  end
end
