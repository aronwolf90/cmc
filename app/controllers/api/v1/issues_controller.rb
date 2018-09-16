# frozen_string_literal: true

module Api
  module V1
    class IssuesController < ApiController
      include StandartActions
      namespace Issues

      public :show, :update, :destroy

      def index
        super(Issue)
      end

    private

      def model
        @model ||= Issue.find(params[:id])
      end
    end
  end
end
