# frozen_string_literal: true

module Api::V1
  class ProjectsController < ApiController
    include StandartActions
    model_class Project

    public :index
  end
end
