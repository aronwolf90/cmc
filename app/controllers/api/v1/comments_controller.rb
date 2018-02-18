# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApiController
      include StandartActions

      def create
        super(operation: Comments::CreateOperation)
      end
    end
  end
end
