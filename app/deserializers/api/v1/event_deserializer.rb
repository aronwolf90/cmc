# frozen_string_literal: true

module Api::V1
  class EventDeserializer < ApiDeserializer
    attribute :title
    attribute :start_time
    attribute :end_time
    attribute :all_day
    attribute :description
  end
end
