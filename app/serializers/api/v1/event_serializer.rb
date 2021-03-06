# frozen_string_literal: true

module Api
  module V1
    class EventSerializer < ApplicationSerializer
      attributes(
        :title,
        :start_time,
        :end_time,
        :all_day,
        :description
      )

      link(:self) { api_v1_event_path(object) }
    end
  end
end
