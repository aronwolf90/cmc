# frozen_string_literal: true

module Api::V1
  class WikiCategoriesController < ApiController
    include StandartActions
    model_class WikiCategory
    serializer WikiCategorySerializer

    public :index
  end
end
