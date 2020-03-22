# frozen_string_literal: true

module Api
  module V1
    module ProjectBoardLists
      class ProjectsController < ApiController
        include StandartActions
        namespace Projects
        model_class Project
        serializer ProjectSerializer
        collection_query Api::V1::ProjectBoardLists::Projects::IndexQuery
        per_page 15

        def index
          render(
            json: collection_result.collection,
            links: { next: next_more_path },
            each_serializer: serializer
          )
        end

        private
          def collection_result
            @collection ||= collection_query.call(
              project_board_list_id: params[:project_board_list_id],
              more_id: params[:more_id],
              per_page: per_page
            )
          end

          def next_more_path
            return unless collection_result.has_more

            api_v1_board_list_issues_path(
              params[:project_board_list_id],
              more_id: next_more_id
            )
          end
      end
    end
  end
end
