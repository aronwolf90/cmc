# frozen_string_literal: true

module Administration
  module Records
    class IndexOperation < Trailblazer::Operation
      step :records
      step :model
      step :records_for_month

      def records(options, params:, current_user:, **)
        options["records"] =
          current_user.records
          .order(start_time: :desc)
          .page(params[:page] || 1)
      end

      def model(options, records:, **)
        options["model"] = records.group_by do |record|
          record.start_time.beginning_of_day
        end
      end

      def records_for_month(options, current_user:, **)
        options["records_for_month"] =
          RecordsForMonthQuery.call(current_user.records)
      end
    end
  end
end
