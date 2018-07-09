# frozen_string_literal: true

module Administration
  module Records
    class ThisMonthSpentTimeStep < ApplicationStep
      def self.call(options, current_user:, **)
        seconds = SpendedTimeCalculator.call(records(current_user))
        options["this_month_spended_time"] = seconds
      end

      def self.records(current_user)
        RecordsIntervalQuery.call(
          current_user.records,
          start_time: Time.zone.now.beginning_of_month,
          end_time: Time.zone.now.end_of_month
        )
      end
    end
  end
end
