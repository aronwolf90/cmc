# frozen_string_literal: true

module Api
  module V1
    class BoardListSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers

      attributes :name

      has_many :issues

      link(:self) { api_v1_board_list_path(object) }
    end
  end
end
