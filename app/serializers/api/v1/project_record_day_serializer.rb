# frozen_string_literal: true

module Api
  module V1
    class ProjectRecordDaySerializer < ApplicationSerializer
      attributes :day

      belongs_to :project, serializer: ProjectSerializer
      has_many :records, serializer: RecordSerializer

      def id
        "#{day}.#{object.project_id}"
      end

      def day
        object.day&.strftime("%d-%m-%Y")
      end
    end
  end
end
