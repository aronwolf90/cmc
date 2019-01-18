# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      class IssuesController < ApiController
        def index
          render(
            json: collection,
            links: {
              next: (api_v1_board_list_issues_path(board_list, more_id: collection.last&.id) if collection.count > 15)
            },
            each_serializer: Api::V1::IssueSerializer
          )
        end

      private

        def collection
          @collection ||=
            if params[:more_id].nil?
              board_list
                .issues
                .limit(15)
            else
              if more_id_issue.ordinal_number.present?
                board_list
                  .issues
                  .where("ordinal_number > ? ", more_id_issue.ordinal_number)
                  .limit(15)
              else
                board_list
                  .issues
                  .where("created_at < ? ", more_id_issue.created_at)
                  .limit(15)
              end
            end
        end

        def board_list
          @board_list ||= BoardList.find(params[:board_list_id])
        end

        def more_id_issue
          @more_id_issue ||= Issue.find(params[:more_id])
        end
      end
    end
  end
end
