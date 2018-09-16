# frozen_string_literal: true

module Administration
  module Projects
    module Records
      class ThisMonthSpentTimeStep < Administration::Records::ThisMonthSpentTimeStep
        def self.call(options, parent:, **)
          seconds = SpendedTimeCalculator.call(records(parent))
          options[:this_month_spended_time] = seconds
        end
      end
    end
  end
end
