# frozen_string_literal: true

module Api::V1
  class IssueDeserializer < ApiDeserializer
    map_attributes :title, :description, :complexity
    map_relationship :user
  end
end
