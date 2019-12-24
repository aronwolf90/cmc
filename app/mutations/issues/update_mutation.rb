# frozen_string_literal: true

module Issues
  class UpdateMutation < StandardUpdateMutation
    def call
      ActiveRecord::Base.transaction do
        super

        next if ordinal_number.nil?

        issue_to_order.each_with_index do |issue, index|
          next if issue == model
          issue.update!(ordinal_number: index)
        end

        issues_after_model.each_with_index do |issue, index|
          issue.update!(ordinal_number: index + ordinal_number + 1)
        end
      end
    end

    private
      def issue_to_order
        model.board_list&.issues&.ordered.to_a.reject do |issue|
          issue == model
        end
      end

      def issues_after_model
        model.board_list.issues.ordered.select do |issue|
          issue.ordinal_number >= ordinal_number &&
            model.id != issue.id
        end
      end

      def ordinal_number
        attributes[:ordinal_number]
      end
  end
end
