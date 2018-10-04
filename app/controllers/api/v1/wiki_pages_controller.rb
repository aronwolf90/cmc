# frozen_string_literal: true

module Api
  module V1
    class WikiPagesController < ApiController
      include StandartActions
      namespace WikiPages
      model_class WikiPage

      public :show, :update, :destroy
    end
  end
end
