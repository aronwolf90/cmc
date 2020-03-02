# frozen_string_literal: true

module Issues
  class UpdateMutation < StandardUpdateMutation
    attr_reader :ordinal_number

    def initialize(ordinal_number: nil, **args)
      @ordinal_number = ordinal_number

      super(args)
    end

    def call
      ActiveRecord::Base.transaction do
        model.send("#{key}=", ordinal_number) if ordinal_number.present?
        board_list_id = attributes.delete(:board_list_id)

        if board_list_id.present?
          if global_board?
            attributes[:global_board_list_id] = board_list_id
          else
            attributes[:board_list_id] = board_list_id
          end
        end

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
        board_list&.issues&.ordered&.to_a.reject do |issue|
          issue == model
        end
      end

      def issues_after_model
        board_list.issues.select do |issue|
          issue.send(key) >= ordinal_number &&
            model.id != issue.id
        end
      end

      def board_list
        if global_board?
          model.global_board_list
        else
          model.board_list
        end
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
  end
end
