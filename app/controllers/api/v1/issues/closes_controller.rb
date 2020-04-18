# frozen_string_literal: true

module Api
  module V1
    module Issues
      class ClosesController < ApiController
        include StandartActions
        serializer IssueSerializer

        def create
          result = Api::V1::Issues::CloseOperation.call(params: params)
          render_json_api(json: result[:model])
        end
      end
    end
  end
end
