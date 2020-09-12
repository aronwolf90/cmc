# frozen_string_literal: true

module Api
  module V1
    class LabelSerializer < ApplicationSerializer
      attributes(
        :name,
        :color
      )

      link(:self) { api_v1_label_path(object) }
    end
  end
end
