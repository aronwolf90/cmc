# frozen_string_literal: true

module Api
  module V1
    class EventSerializer < ApplicationSerializer
      set_type :events

      attributes(
        :title,
        :start_time,
        :end_time,
        :all_day,
        :description
      )

      link(:self) { |object| "/api/v1/event/#{object.id}" }
    end
  end
end
