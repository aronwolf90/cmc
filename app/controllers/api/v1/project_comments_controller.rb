# frozen_string_literal: true

module Api
  module V1
    class ProjectCommentsController < ApiController
      include StandartActions
      namespace ProjectComments
      model_class ProjectComment
      serializer ProjectCommentSerializer

      public :create
    end
  end
end
