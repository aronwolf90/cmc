# frozen_string_literal: true

module Api
  module V1
    module ProjectStatuses
      class ShowQuery < ApplicationQuery
        attr_reader :project_status_id, :includes

        def initialize(project_status_id:, includes:)
          @project_status_id = project_status_id
          @includes = includes
        end

        def call
          ProjectStatus.find(project_status_id).tap do |project_status|
            next unless includes.include?("project_board_lists")

            project_board_lists = Api::V1::ProjectBoardLists::IndexQuery.call(
              project_status: project_status
            )
            Api::V1::ProjectStatuses::ShowPreloader.call(
              project_status,
              project_board_lists: project_board_lists
            )
          end
        end
      end
    end
  end
end
