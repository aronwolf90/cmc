# frozen_string_literal: true

module Api::V1
  class RecordDeserializer < ApiDeserializer
    map_attributes :start_time, :end_time
    map_relationships :user, :issue
  end
end
