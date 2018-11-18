# frozen_string_literal: true

module Administration
  module Dashboard
    class ShowOperation < ApplicationOperation
      success ProjectsStep
      success :worked_issues
      success :assigned_issues
      success :events

    private

      def worked_issues(options, current_user:, **)
        options["model"][:worked_issues] =
          current_user.worked_issues.includes(:records, :project)
      end

      def assigned_issues(options, current_user:, **)
        options["model"][:assigned_issues] =
          current_user.issues.includes(:records, :project)
      end

      def events(options, current_user:, **)
        options["model"][:events] = Event.all.ordered
      end
    end
  end
end
