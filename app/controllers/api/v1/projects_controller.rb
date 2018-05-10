# frozen_string_literal: true

module Api::V1
  class ProjectsController < ApiController
    include StandartActions

    def index
      render json: Project.all, include: :current_record
    end
  end
end
