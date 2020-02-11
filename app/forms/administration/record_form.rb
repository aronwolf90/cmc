# frozen_string_literal: true

require "reform/form/coercion"
gem "dry-types"

module Administration
  class RecordForm < ApplicationForm
    model ::Record

    property :id
    property :start_time, type: Types::Form::DateTime
    property :end_time, type: Types::Form::DateTime
    property :current_user, virtual: true
    property :issue_id

    validates :current_user, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :issue_id, presence: true

    validate :start_time_before_end
    validate :no_overlapping

    private
      def start_time_before_end
        return if start_time.blank?
        return if end_time.blank?
        return if start_time < end_time

        errors.add(:start_time, "End time before start time")
      end

      def no_overlapping
        return if end_time.blank?
        return if other_records.empty?

        errors.add(:start_time, "Overlapping with other record")
      end

      def other_records
        OtherUserRecordsIntervalQuery.call(
          user: current_user,
          start_time: start_time,
          end_time: end_time,
          record_id: id
        )
      end
  end
end
