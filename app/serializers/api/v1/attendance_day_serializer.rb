# frozen_string_literal: true

module Api
  module V1
    class AttendanceDaySerializer < ApplicationSerializer
      attributes :day, :kind
    end
  end
end
