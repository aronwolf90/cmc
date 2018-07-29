# frozen_string_literal: true

module Api
  module V1
    class IssuesController < ApiController
      include StandartActions

      def index
        super(Issue)
      end

      def show
        super(issue)
      end

      def update
        super(operation: Issues::UpdateOperation, model: issue)
      end

      def destroy
        super(model: issue)
      end

    private

      def issue
        @issue ||= Issue.find(params[:id])
      end
    end
  end
end
