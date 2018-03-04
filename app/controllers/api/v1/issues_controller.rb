# frozen_string_literal: true

module Api
  module V1
    class IssuesController < ApiController
      include StandartActions

      def show
        render json: issue, include: :comments
      end

      def update
        super(operation: Issues::UpdateOperation, model: issue)
      end

    private

      def issue
        @issue ||= Issue.find(params[:id])
      end
    end
  end
end