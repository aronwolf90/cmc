# frozen_string_literal: true

module Api::V1
  class WikiCategoriesController < ApiController
    include StandartActions
    model_class WikiCategory
    serializer WikiCategorySerializer
    namespace WikiCategories

    per_page 400

    public :index, :show, :update, :create, :destroy
  end
end
