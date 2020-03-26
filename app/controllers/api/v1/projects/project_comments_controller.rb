# frozen_string_literal: true

module Api::V1
  module Projects
    class ProjectCommentsController < ApiController
      include StandartActions
      serializer ProjectCommentSerializer

      public :index

    private
      def query
        JsonApiQuery.call(
          Project.find(params[:project_id]).project_comments.ordered.includes(serializer.eager_load_options),
          params.to_unsafe_h.deep_symbolize_keys
        )
      end
    end
  end
end
