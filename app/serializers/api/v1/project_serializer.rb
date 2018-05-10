# frozen_string_literal: true

module Api
  module V1
    class ProjectSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers

      attributes :name
    end
  end
end
