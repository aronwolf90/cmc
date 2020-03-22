# frozen_string_literal: true

module Api
  module V1
    module ProjectBoardLists
      module Projects
        class IndexQuery < ApplicationQuery
          attr_reader :project_board_list_id, :more_id, :per_page

          def initialize(project_board_list_id:, more_id:, per_page:)
            @project_board_list_id = project_board_list_id
            @more_id = more_id
            @per_page = per_page
          end

          def call
            MoreCollectionQuery.call(
              collection,
              more_id: more_id,
              per_page: per_page,
              sort_key: :ordinal_number
            )
          end

          def collection
            @collection ||= ProjectBoardList.find(project_board_list_id).projects
          end
        end
      end
    end
  end
end
