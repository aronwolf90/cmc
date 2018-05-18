# frozen_string_literal: true

module Api::V1
  class UserDeserializer < ApiDeserializer
    belongs_to :selected_project
  end
end
