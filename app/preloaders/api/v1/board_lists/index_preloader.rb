# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      class IndexPreloader < ApplicationPreloader
        attr_accessor :collection, :issues, :includes

        def initialize(collection, issues:, includes: [])
          @collection = collection
          @issues = issues
          @includes = includes
        end

        def call
          collection.each do |board_list|
            board_list_issues = find_issues_for_board_list(board_list)
            board_list_issues = order_issues(board_list, board_list_issues)
            board_list.instance_variable_set(:@issues, board_list_issues)
            board_list_issues.each do |issue|
              association = issue.association(:board_list)
              association.loaded!
              association.target = board_list
            end
          end

          collection
        end

      private
        def find_issues_for_board_list(board_list)
          issues.select do |issue|
            board_list.id.in?([issue.board_list_id, issue.global_board_list_id])
          end
        end

        def order_issues(board_list, issues)
          if board_list.project_id.nil?
            issues.sort_by(&:global_ordinal_number)
          else
            issues.sort_by(&:ordinal_number)
          end
        end
      end
    end
  end
end
