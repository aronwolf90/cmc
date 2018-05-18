# frozen_string_literal: true

module Api::V1
  class RecordDeserializer < ApiDeserializer
    attribute :start_time
    attribute :end_time
    belongs_to :user
    belongs_to :issue
  end
end
