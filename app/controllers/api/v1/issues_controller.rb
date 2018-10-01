# frozen_string_literal: true

module Api
  module V1
    class IssuesController < ApiController
      include StandartActions
      namespace Issues
      model_class Issue

      public :index, :show, :update, :destroy
    end
  end
end
