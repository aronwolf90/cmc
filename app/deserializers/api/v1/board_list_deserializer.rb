# frozen_string_literal: true

module Api::V1
  class BoardListDeserializer < ApiDeserializer
    map_attributes :name, :ordinal_number
    map_relationship :issues, array: true, sort_attribute: :ordinal_number
  end
end
