# frozen_string_literal: true

module Api
  module V1
    class IssuesController < ApiController
      include StandartActions
      namespace Issues
      model_class Issue
      serializer IssueSerializer
      per_page 15

      public :index, :show, :create, :update, :destroy

      private
        def query
          super.page(params[:page]).per(15)
        end
    end
  end
end
