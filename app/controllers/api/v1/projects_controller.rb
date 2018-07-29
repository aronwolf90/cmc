# frozen_string_literal: true

module Api::V1
  class ProjectsController < ApiController
    include StandartActions

    def index
      super(Project)
    end
  end
end
