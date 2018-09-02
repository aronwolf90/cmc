# frozen_string_literal: true

module Organizations
  class UpdateMutation < ApplicationMutation
    def call
      model.update!(
        attributes.merge(
          time_zone_seconds: time_zone_seconds
      ))
    end

    def time_zone_seconds
      @time_zone_seconds ||=
        Time.now.in_time_zone(attributes[:time_zone]).utc_offset
    end
  end
end
