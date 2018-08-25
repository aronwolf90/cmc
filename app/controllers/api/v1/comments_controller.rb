# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApiController
      include StandartActions
      namespace Comments

      def create
        super
      end
    end
  end
end
