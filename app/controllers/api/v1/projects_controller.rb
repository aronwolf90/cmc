# frozen_string_literal: true

module Api::V1
  class ProjectsController < ApiController
    include StandartActions
    model_class Project
    serializer ProjectSerializer
    namespace Projects

    public :index, :show, :create, :destroy

    def update
      result = run namespace::UpdateOperation

      if result.success?
        render json: result[:model], status: :ok
      else
        render_errors(result[:errors])
      end
    end

    private def query
      Api::V1::Projects::IndexQuery.call(
        query: params[:query],
        includes: params[:include]
      )
    end
  end
end
