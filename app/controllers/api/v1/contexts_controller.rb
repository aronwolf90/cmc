# frozen_string_literal: true

module Api
  module V1
    class ContextsController < ApiController
      def show
        render json: Context.new(current_user: current_user), include: [:current_user,  "current_user.current_record"]
      end
    end
  end
end
