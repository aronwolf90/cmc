# frozen_string_literal: true

module Api
  module V1
    class WikiPagesController < ApiController
      include StandartActions

      def show
        super(wiki_page)
      end

      def update
        super(operation: WikiPages::UpdateOperation)
      end

    private

      def wiki_page
        WikiPage.find(params[:id])
      end
    end
  end
end
