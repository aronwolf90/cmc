# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      class IssuesController < ApiController
        def index
          render(
            json: collection.limit(15),
            links: { next: next_more_path },
            each_serializer: Api::V1::IssueSerializer
          )
        end

      private

        def collection
          MoreCollectionQuery.(
            board_list.issues,
            more_id: params[:more_id],
          )
        end

        def next_more_path
          return if next_more_id.nil?
          api_v1_board_list_issues_path(
            board_list,
            more_id: next_more_id
          )
        end

        def next_more_id
          return if collection.count <= 15
          collection.limit(15).last&.id
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
