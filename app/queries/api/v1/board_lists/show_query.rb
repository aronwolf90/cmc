# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      class ShowQuery < ApplicationQuery
        attr_reader :id, :project_id, :issues_count

        def initialize(id:, project_id: nil, issues_count: 16)
          @id = id
          @project_id = project_id
          @issues_count = issues_count
        end

        def call
          board_list = BoardList.find(id)
          issues = Api::V1::BoardLists::Index::IssuesQuery.call(
            [board_list],
            project_id: project_id,
            count: issues_count
          )
          Api::V1::BoardLists::IndexPreloader.call(
            [board_list],
            issues: issues
          )
          board_list
        end
      end
    end
  end
end
