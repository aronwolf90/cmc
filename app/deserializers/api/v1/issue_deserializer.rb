# frozen_string_literal: true

module Api::V1
  class IssueDeserializer < ApiDeserializer
    attribute :title
    attribute :description
    attribute :complexity
    attribute :ordinal_number
    attribute :due_at
    attribute :deadline_at
    belongs_to :user
    belongs_to :board_list
    belongs_to :project
    has_many :labels
  end
end
