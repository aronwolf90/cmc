# frozen_string_literal: true

module Administration
  module ProjectRecords
    class ThisMonthSpentTimeStep < Records::ThisMonthSpentTimeStep
      def self.call(options, project:, **)
        seconds = SpendedTimeCalculator.call(records(project))
        options["this_month_spended_time"] = seconds
      end
    end
  end
end
