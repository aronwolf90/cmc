# frozen_string_literal: true

module Api::V1
  class UserDeserializer < ApiDeserializer
    map_relationship :selected_project
  end
end
