# frozen_string_literal: true

module Administration::Dashboard
  class ProjectsStep < ApplicationStep
    def self.call(options, current_user:, **)
      init(options)

      options["model"][:projects] =
        Project.all.map do |project|
        [
          project,
          total_spent_time(current_user, project),
          month_spent_time(current_user, project),
          last_month_spent_time(current_user, project)
        ]
      end
    end

    def self.init(options)
      options["model"] ||= {}
      options["model"][:projects] ||= {}
    end

    def self.total_spent_time(current_user, project)
      records = RecordsUserProjectQuery.call(
        user: current_user,
        project: project
      )

      SqlSpendedTimeCalculator.(records)
    end

    def self.month_spent_time(current_user, project)
      records = RecordsMonthUserProjectQuery.(
        user: current_user,
        project: project
      )

      SqlSpendedTimeCalculator.(records)
    end

    def self.last_month_spent_time(current_user, project)
      records = RecordsMonthUserProjectQuery.(
        user: current_user,
        project: project,
        month: 1.month.ago
      )

      SqlSpendedTimeCalculator.(records)
    end
  end
end
