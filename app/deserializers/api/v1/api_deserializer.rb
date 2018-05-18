# frozen_string_literal: true

require Rails.root.join("lib", "json_api_deserializer")

module Api::V1
  class ApiDeserializer < JsonApiDeserializer
  end
end
