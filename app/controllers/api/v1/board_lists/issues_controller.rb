# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      class IssuesController < ApiController
        per_page 15
        serializer Api::V1::IssueSerializer
        collection_query Api::V1::BoardLists::Issues::IndexQuery

        def index
          render json: serializer.new(collection_result.collection, {
            links: { next: next_more_path }
          })
        end

        private
          def collection_result
            @collection ||= collection_query.call(
              board_list_id: params[:board_list_id],
              project_id: params.dig(:filter, :project_id),
              more_id: params[:more_id],
              per_page: per_page
            )
          end

          def next_more_path
            return unless collection_result.has_more

            api_v1_board_list_issues_path(
              params[:board_list_id],
              more_id: next_more_id
            )
          end
      end
    end
  end
end
