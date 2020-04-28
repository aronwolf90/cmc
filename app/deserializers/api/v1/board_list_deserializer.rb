# frozen_string_literal: true

module Api::V1
  class BoardListDeserializer < ApiDeserializer
    attribute :name
    attribute :ordinal_number
    has_many :issues
    has_many_sort :issues, attribute: :ordinal_number
    belongs_to :project
  end
end
