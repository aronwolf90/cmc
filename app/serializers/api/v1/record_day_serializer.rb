# frozen_string_literal: true

module Api
  module V1
    class RecordDaySerializer < ApplicationSerializer
      attributes :day

      belongs_to :user, serializer: UserSerializer
      has_many :records, serializer: RecordSerializer

      def id
        "#{day}.#{object.user_id}"
      end

      def day
        object.day&.strftime("%d-%m-%Y")
      end
    end
  end
end
