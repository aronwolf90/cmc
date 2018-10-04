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

    validation with: { form: true } do
      configure do
        predicates(ReformPredicates)

        def before_end?(start_time)
          form.end_time.blank? || start_time < form.end_time
        end

        def no_overlapping?(start_time)
          return true if form.end_time.blank?

          RecordsIntervalQuery.call(
            form.current_user.records.all_except(form.id),
            start_time: start_time,
            end_time: form.end_time
          ).empty?
        end
      end

      optional(:id).maybe
      required(:current_user).filled
      required(:start_time).filled(:before_end?, :no_overlapping?)
      optional(:end_time).filled
      required(:issue_id).filled(exists?: ::Issue)
    end
  end
end
