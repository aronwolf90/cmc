# frozen_string_literal: true

module Api
  module V1
    class ProjectBoardListsController < ApiController
      include StandartActions
      namespace ProjectBoardLists
      model_class ProjectBoardList

      public :show, :create, :update, :destroy
    end
  end
end
