# frozen_string_literal: true

module Api::V1
  class LabelDeserializer < ApiDeserializer
    attribute :name
    attribute :color
  end
end
