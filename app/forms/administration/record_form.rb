# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class RecordForm < Reform::Form
    feature Coercion
    model ::Record

    property :id
    property :start_time, type: Types::Form::DateTime
    property :end_time, type: Types::Form::DateTime
    property :current_user, virtual: true
    property :issue_id

    validation do
      configure do
        predicates(ReformPredicates)
      end

      optional(:id).maybe
      required(:current_user).filled
      required(:start_time).filled
      optional(:end_time).maybe
      required(:issue_id).filled(exists?: ::Issue)

      validate start_before_end: %i[start_time end_time] do |start_time, end_time|
        end_time.nil? || start_time < end_time
      end

      validate no_overlapping_records: %i[id current_user start_time end_time] do
        |id, current_user, start_time, end_time|

        RecordsIntervalQuery.call(
          current_user.records.all_except(id),
          start_time: start_time,
          end_time: end_time || Time.zone.now
        ).empty?
      end
    end
  end
end
