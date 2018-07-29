# frozen_string_literal: true

module Api::V1
  class WikiCategoriesController < ApiController
    include StandartActions

    def index
      super(WikiCategory)
    end
  end
end
