# frozen_string_literal: true

module Administration
  module Records::Cell
    class Index < ApplicationCell
    private
      def format_day(day)
        l(day, format: "%A %d.%m.%Y")
      end

      def format_time(time)
        l(time, format: "%I:%M %P")
      end

      def add_btn
        super(Record)
      end

      def csv_btn
        standard_btn fa_icon(:"file-excel-o"),
          administration_records_path(format: :csv)
      end

      def spended_time(record_day)
        seconds_to_time(SpendedTimeCalculator.call(record_day.records))
      end

      def month_spended_time
        seconds_to_time(options[:this_month_spended_time])
      end
    end
  end
end
