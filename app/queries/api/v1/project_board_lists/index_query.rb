# frozen_string_literal: true

module Api
  module V1
    module ProjectBoardLists
      class IndexQuery < ApplicationQuery
        attr_reader :project_status, :projects_count

        def initialize(project_status:, projects_count: 16)
          @project_status = project_status
          @projects_count = projects_count
        end

        def call
          project_board_lists = project_status.project_board_lists
          projects = Api::V1::ProjectBoardLists::Index::ProjectsQuery.call(
            project_board_lists,
            count: projects_count
          )
          Api::V1::ProjectBoardLists::IndexPreloader.call(project_board_lists, projects: projects)
        end
      end
    end
  end
end
