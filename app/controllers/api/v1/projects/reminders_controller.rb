# frozen_string_literal: true

module Api
  module V1
    module Projects
      class RemindersController < ApiController
        include StandartActions
        serializer IssueSerializer
        collection_query Api::V1::Projects::Reminders::IndexQuery

        def index
          render_json_api(
            json: collection_query.call(params[:project_id]).collection
          )
        end
      end
    end
  end
end
