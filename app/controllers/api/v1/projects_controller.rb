# frozen_string_literal: true

module Api::V1
  class ProjectsController < ApiController
    include StandartActions
    model_class Project
    serializer ProjectSerializer

    public :index
  end
end
