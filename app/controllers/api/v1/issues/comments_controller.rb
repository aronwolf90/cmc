# frozen_string_literal: true

module Api
  module V1
    module Issues
      class CommentsController < ApiController
        include StandartActions
        namespace Comments
        model_class Comment
        serializer CommentSerializer

        public :index

      private
        def query
          issues = Issue.find(params[:issue_id])
            .comments.ordered.includes(serializer.eager_load_options)
          JsonApiQuery.call(
            issues,
            params.to_unsafe_h.deep_symbolize_keys
          )
        end
      end
    end
  end
end
