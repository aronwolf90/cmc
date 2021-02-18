# frozen_string_literal: true

module Issues
  class MoveMutation < ApplicationMutation
    attr_reader :issue, :before_issue, :board_list

    def initialize(issue:, before_issue:, board_list:)
      @issue = issue
      @before_issue = before_issue
      @board_list = board_list
    end

    def call
      ActiveRecord::Base.transaction do
        if board_list.project.blank?
          issue.update!(global_board_list: board_list)
        else
          issue.update!(board_list: board_list)
        end

        if before_issue.blank? || before_issue.board_list == issue.board_list
          issue.update!(ordinal_number: ordinal_number)
          SortMutation.call(
            Issue.where(board_list_id: issue.board_list_id),
            model: issue,
            sort_key: :ordinal_number,
            sort_value: ordinal_number
          )
        end

        if before_issue.blank? || before_issue.global_board_list == issue.global_board_list
          issue.update!(global_ordinal_number: global_ordinal_number)
          SortMutation.call(
            Issue.where(global_board_list_id: issue.global_board_list_id),
            model: issue,
            sort_key: :global_ordinal_number,
            sort_value: global_ordinal_number
          )
        end
      end
    end

    private def ordinal_number
      return 0 if before_issue.blank?

      Issue
        .where("ordinal_number < :ordinal_number "\
               "OR (ordinal_number=:ordinal_number AND created_at>:created_at) "\
               "OR (ordinal_number=:ordinal_number AND created_at=:created_at AND id>:id)",
               ordinal_number: before_issue.ordinal_number,
               created_at: before_issue.created_at,
               id: before_issue.id)
        .where(board_list: before_issue.board_list)
        .count + 1
    end

    private def global_ordinal_number
      return 0 if before_issue.blank?

      Issue
        .where("global_ordinal_number < :global_ordinal_number "\
               "OR (global_ordinal_number=:global_ordinal_number AND created_at>:created_at) "\
               "OR (global_ordinal_number=:global_ordinal_number AND created_at=:created_at AND id>:id)",
               global_ordinal_number: before_issue.global_ordinal_number,
               created_at: before_issue.created_at,
               id: before_issue.id)
        .where(global_board_list: before_issue.global_board_list)
        .count + 1
    end
  end
end
