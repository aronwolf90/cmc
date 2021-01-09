# frozen_string_literal: true

module Api
  module V1
    class RecordDaySerializer < ApplicationSerializer
      attributes :day, :spent_time

      belongs_to :user, serializer: UserSerializer
      has_many :records, serializer: RecordSerializer

      def id
        "#{day}.#{object.user_id}"
      end

      def day
        object.day&.strftime("%d-%m-%Y")
      end

      def spent_time
        object.spent_time.to_i
      end
    end
  end
end
