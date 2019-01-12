# frozen_string_literal: true

module Api::V1
  class IssueDeserializer < ApiDeserializer
    attribute :title
    attribute :description
    attribute :complexity
    attribute :ordinal_number
    belongs_to :user
    belongs_to :board_list
  end
end
