# frozen_string_literal: true

module Api
  module V1
    class ProjectBoardListsController < ApiController
      include StandartActions
      namespace ProjectBoardLists
      model_class ProjectBoardList

      public :update
    end
  end
end
