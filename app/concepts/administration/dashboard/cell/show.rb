# frozen_string_literal: true

module Administration
  module Dashboard::Cell
    class Show < ApplicationCell
      def spendet_time(issue)
        seconds_to_time(
          SpendedTimeIssueUserCalculator.(issue, current_user)
        )
      end
    end
  end
end
