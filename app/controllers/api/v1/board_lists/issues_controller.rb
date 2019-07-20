# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      class IssuesController < ApiController
        per_page 15

        def index
          render(
            json: collection.limit(per_page),
            links: { next: next_more_path },
            each_serializer: Api::V1::IssueSerializer
          )
        end

        private
          def collection
            MoreCollectionQuery.call(
              board_list.issues,
              more_id: params[:more_id]
            )
          end

          def next_more_path
            return if collection.count <= per_page

            api_v1_board_list_issues_path(
              board_list,
              more_id: next_more_id
            )
          end

          def next_more_id
            collection.limit(per_page).last.id
          end

          def board_list
            @board_list ||= BoardList
                            .includes(:issues)
                            .find(params[:board_list_id])
          end

          def more_id_issue
            @more_id_issue ||= Issue.find(params[:more_id])
          end
      end
    end
  end
end
