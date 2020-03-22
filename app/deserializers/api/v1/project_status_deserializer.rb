# frozen_string_literal: true

module Api::V1
  class ProjectStatusDeserializer < ApiDeserializer
    attribute :name
    attribute :ordinal_number
  end
end
