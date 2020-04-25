# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      module Index
        class IssuesQuery < ApplicationQuery
          attr_reader :board_lists, :project_id, :count

          def initialize(board_lists, project_id: nil, count: 15)
            @board_lists = board_lists
            @project_id = project_id
            @count = count
          end

          def call
            issues = board_lists.map(&:issues).inject(Issue.none) do |query, issues_query|
              query.union(issues_query.limit(count))
            end
            if project_id.present?
              IssuesProjectQuery.(issues, project_id: project_id)
            else
              issues
            end
          end
        end
      end
    end
  end
end
