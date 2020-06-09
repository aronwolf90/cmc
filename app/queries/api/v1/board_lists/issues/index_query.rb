# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      module Issues
        class IndexQuery < ApplicationQuery
          attr_reader :board_list_id, :more_id, :per_page, :project_id

          def initialize(board_list_id:, more_id:, per_page:, project_id: nil)
            @board_list_id = board_list_id
            @more_id = more_id
            @per_page = per_page
            @project_id = project_id
          end

          def call
            MoreCollectionQuery.call(
              collection,
              more_id: more_id,
              per_page: per_page,
              sort_key: Organization.global_board? ? :global_ordinal_number : :ordinal_number
            )
          end

          def collection
            collection = BoardList.find(board_list_id).issues
            if project_id.present?
              IssuesProjectQuery.(collection, project_id: project_id)
            else
              collection
            end
          end
        end
      end
    end
  end
end
