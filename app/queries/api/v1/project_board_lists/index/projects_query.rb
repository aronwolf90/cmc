# frozen_string_literal: true

module Api
  module V1
    module ProjectBoardLists
      module Index
        class ProjectsQuery < ApplicationQuery
          attr_reader :project_board_lists, :count

          def initialize(project_board_lists, count: 15)
            @project_board_lists = project_board_lists
            @count = count
          end

          def call
            project_board_lists.map(&:projects).inject(Project.none) do |query, projects_query|
              query.union(projects_query.limit(count))
            end
          end
        end
      end
    end
  end
end
