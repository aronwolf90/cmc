# frozen_string_literal: true

module Api::V1
  class AttendanceEventDeserializer < ApiDeserializer
    attribute :from_day
    attribute :to_day
    attribute :from_time
    attribute :to_time
    attribute :description

    belongs_to :user
  end
end
