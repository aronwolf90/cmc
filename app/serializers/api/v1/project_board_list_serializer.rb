# frozen_string_literal: true

module Api
  module V1
    class ProjectBoardListSerializer < ApplicationSerializer
      include Rails.application.routes.url_helpers

      attributes :name
      has_many :projects, serializer: ProjectSerializer
    end
  end
end
