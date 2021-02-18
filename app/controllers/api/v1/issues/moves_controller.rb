# frozen_string_literal: true

module Api
  module V1
    module Issues
      class MovesController < ApiController
        include StandartActions
        serializer IssueSerializer

        def create
          result = Api::V1::Issues::MoveOperation.call(
            current_user: current_user,
            issue_id: params[:issue_id],
            before_issue_id: params[:before_issue_id],
            board_list_id: params[:board_list_id]
          )

          if result.success?
            render(
              json: result[:issue],
              status: :ok,
              serializer: IssueSerializer
            )
          elsif result[:form].failure?
            render_errors(result[:form].errors)
          elsif !result[:policy]
            head :unauthorized
          end
        end
      end
    end
  end
end
