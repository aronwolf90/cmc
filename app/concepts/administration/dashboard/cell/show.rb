# frozen_string_literal: true

module Administration
  module Dashboard::Cell
    class Show < ApplicationCell
      def spendet_time(issue)
        SpendedTimeIssueUserCalculator.(issue, current_user)
      end
    end
  end
end
