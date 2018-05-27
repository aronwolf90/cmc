# frozen_string_literal: true

module Api
  module V1
    class WikiPagesController < ApiController
      include StandartActions

      def show
        render json: wiki_page
      end

      def update
        super(operation: WikiPages::UpdateOperation, model: wiki_page)
      end

    private

      def wiki_page
        WikiPage.find(params[:id])
      end
    end
  end
end
