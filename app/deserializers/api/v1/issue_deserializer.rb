# frozen_string_literal: true

module Api::V1
  class IssueDeserializer < ApiDeserializer
    attribute :title
    attribute :description
    attribute :complexity
    belongs_to :user
  end
end
