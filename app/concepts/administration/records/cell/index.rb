# frozen_string_literal: true

module Administration
  module Records::Cell
    class Index < ApplicationCell
    private

      def add_link
        return unless policy(Record).new?
        link_to "New record", new_administration_record_path,
          class: "btn btn-success"
      end

      def edit_btn(record)
        return unless policy(record).edit?
        link_to fa_icon(:edit), [:edit, :administration, record],
          class: "btn btn-sm btn-secondary"
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
