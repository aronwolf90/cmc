# frozen_string_literal: true

module Api::V1
  module Users
    class ConfigurationDeserializer < ApiDeserializer
      attribute :type
    end
  end
end
