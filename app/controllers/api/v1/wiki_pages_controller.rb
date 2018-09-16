# frozen_string_literal: true

module Api
  module V1
    class WikiPagesController < ApiController
      include StandartActions
      namespace WikiPages

      public :show, :update

    private

      def model
        @model ||= WikiPage.find(params[:id])
      end
    end
  end
end
