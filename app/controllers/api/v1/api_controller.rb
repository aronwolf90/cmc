module Api
  module V1
    class ApiController < ApplicationController
      def render_errors(errors)
        render json: OpenStruct.new(errors: OpenStruct.new(messages: errors)), status: :bad_request,
               serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end
  end
end
