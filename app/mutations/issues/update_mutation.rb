# frozen_string_literal: true

module Issues
  class UpdateMutation < StandardUpdateMutation
    def call
      ActiveRecord::Base.transaction do
        super

        return if ordinal_number.nil?

        issues_without_ordinal_number.each_with_index do |issue, index|
          issue.update!(ordinal_number: max_ordinal_number + index)
        end

        issues_after_model.each_with_index do |issue, index|
          issue.update!(ordinal_number: index + ordinal_number + 1)
        end
      end
    end

    private
      def issues_without_ordinal_number
        model.board_list.issues.select do |issue|
          issue.ordinal_number.nil?
        end
      end

      def max_ordinal_number
        @max_ordinal_number ||= model.board_list.issues.max_by do |issue|
          issue.ordinal_number || 0
        end.ordinal_number
      end

      def issues_after_model
        model.board_list.issues.select do |issue|
          issue.ordinal_number >= ordinal_number &&
            model.id != issue.id
        end
      end

      def ordinal_number
        attributes[:ordinal_number]
      end
  end
end
