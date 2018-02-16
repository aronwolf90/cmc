# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApiController
      def create
        result = Comments::CreateTransacion.call(params.to_unsafe_h)

        if result.success?
          render json: result.success, status: :created
        else
          render_errors(result.failure)
        end
      end
    end
  end
end
