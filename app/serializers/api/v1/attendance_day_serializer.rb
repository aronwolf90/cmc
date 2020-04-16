# frozen_string_literal: true

module Api
  module V1
    class AttendanceDaySerializer < ApplicationSerializer
      set_type :"attendance-days"

      attributes :day, :kind
    end
  end
end
