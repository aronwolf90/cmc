module Administration
  module Issue
    class EditForm < BaseForm
      attr_reader :issue, :board_list

      def initialize(issue:, board_list:, params: {})
        @issue = issue
        @board_list = board_list

        super({
          title: issue.title,
          description: issue.description,
          board_list_id: board_list.id
        }.merge(params))
      end

      def persisted?
        true
      end

      def id
        issue.id
      end

      def update
        return false if invalid?

        issue.update!(title: title, description: description)

        true
      end
    end
  end
end
