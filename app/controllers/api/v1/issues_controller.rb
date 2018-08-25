# frozen_string_literal: true

module Api
  module V1
    class IssuesController < ApiController
      include StandartActions
      namespace Issues

      def index
        super(Issue)
      end

      def show
        super
      end

      def update
        super
      end

      def destroy
        super
      end

    private

      def model
        @model ||= Issue.find(params[:id])
      end
    end
  end
end
