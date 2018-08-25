# frozen_string_literal: true

module Api
  module V1
    class WikiPagesController < ApiController
      include StandartActions
      namespace WikiPages

      def show
        super
      end

      def update
        super
      end

    private

      def model
        @model ||= WikiPage.find(params[:id])
      end
    end
  end
end
