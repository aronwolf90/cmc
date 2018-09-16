# frozen_string_literal: true

module Administration
  module Users
    module Records
      class IndexMonthTimeStep < Administration::Records::ThisMonthSpentTimeStep
        def self.call(options, parent:, **)
          seconds = SpendedTimeCalculator.call(records(parent))
          options[:this_month_spended_time] = seconds
        end
      end
    end
  end
end
