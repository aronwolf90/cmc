# frozen_string_literal: true

module Issues
  class UpdateMutation < StandardUpdateMutation
    attr_reader :ordinal_number

    def initialize(ordinal_number: nil, **args)
      @ordinal_number = ordinal_number

      super(args)
    end

    def call
      model.send("#{key}=", ordinal_number) if ordinal_number.present?
      board_list_id = attributes.delete(:board_list_id)

      if board_list_id.present?
        if global_board?
          attributes[:global_board_list_id] = board_list_id
          if board_list.closed? && project_closed_board_list.present?
            attributes[:board_list_id] = project_closed_board_list.id
            attributes[:ordinal_number] = 0
          end
        else
          attributes[:board_list_id] = board_list_id
          if board_list.closed? && global_closed_board_list.present?
            attributes[:global_board_list_id] = global_closed_board_list.id
            attributes[:global_ordinal_number] = 0
          end
        end
      end

      issue_to_order = issue_to_order()

      ActiveRecord::Base.transaction do
        super

        next if ordinal_number.nil?

        issue_to_order.each_with_index do |issue, index|
          issue.update!(key => index)
        end

        issues_after_model.each_with_index do |issue, index|
          issue.update!(key => index + ordinal_number + 1)
        end
      end
    end

    private
      def issue_to_order
        issues = board_list&.issues&.sort_by do |issue|
          [issue.send(key), issue.id]
        end.to_a

        issues.reject do |issue|
          issue == model
        end
      end

      def issues_after_model
        board_list.issues.select do |issue|
          issue.send(key) >= ordinal_number &&
            model != issue
        end
      end

      def board_list
        @board_list ||= BoardList.find_by(id:
          attributes[:board_list_id] || attributes[:global_board_list_id]
        )
      end

      def key
        if global_board?
          :global_ordinal_number
        else
          :ordinal_number
        end
      end

      def global_board?
        Organization.global_board?
      end

      def project_closed_board_list
        @project_closed_board_list ||=
          BoardList.closed.find_by(project: model.board_list.project)
      end

      def global_closed_board_list
        @global_closed_board_list ||= BoardList.closed.find_by(project: nil)
      end
  end
end
