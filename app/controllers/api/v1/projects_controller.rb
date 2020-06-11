# frozen_string_literal: true

module Api::V1
  class ProjectsController < ApiController
    include StandartActions
    model_class Project
    serializer ProjectSerializer
    namespace Projects

    public :index, :show, :create, :update, :destroy

    private def query
      Api::V1::Projects::IndexQuery.call(query: params[:query])
    end
  end
end
