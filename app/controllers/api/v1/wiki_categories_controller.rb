# frozen_string_literal: true

module Api::V1
  class WikiCategoriesController < ApiController
    def index
      render json: WikiCategory.all, include: :wiki_pages
    end
  end
end
