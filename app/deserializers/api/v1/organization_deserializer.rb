# frozen_string_literal: true

module Api::V1
  class OrganizationDeserializer < ApiDeserializer
    attribute :time_zone
    attribute :global_board
  end
end
