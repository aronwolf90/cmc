module Administration
  module Issue
    class NewForm < BaseForm
      attr_reader :issue, :board_list

      def initialize(board_list:, params: {})
        @board_list = board_list

        super({ board_list_id: board_list.id }.merge(params))
      end

      def save
        return false if invalid?

        ActiveRecord::Base.transaction do
          issue.save!
          board_list_issue_relation.save!
        end

        true
      end

      def issue
        @issue ||= ::Issue.new(title: title, description: description)
      end

      def board_list_issue_relation
        @board_list_issue_relation ||=
          issue.board_list_issue_relations.build(board_list: board_list)
      end
    end
  end
end
