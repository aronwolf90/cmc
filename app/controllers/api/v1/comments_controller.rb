# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApiController
      include StandartActions
      namespace Comments
      model_class Comment
      serializer CommentSerializer

      public :create
    end
  end
end
