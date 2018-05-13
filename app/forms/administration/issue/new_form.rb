# frozen_string_literal: true

module Administration
  module Issue
    class NewForm < BaseForm
      attr_reader :board_list

      def initialize(board_list:, params: {})
        @board_list = board_list
        super({ board_list_id: board_list.id }.merge(params))
      end

      def save
        return false if invalid?
        issue.save!
        true
      end

    private

      def issue
        @issue ||= ::Issue.new(
          title: title,
          description: description,
          board_list_id: board_list_id
        )
      end
    end
  end
end
