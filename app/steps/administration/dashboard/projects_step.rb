# frozen_string_literal: true

module Administration::Dashboard
  class ProjectsStep < ApplicationStep
    def self.call(options, current_user:, params:,**)
      init(options)

      projects =
        Project.ordered.page(params[:project_page] || 1).per(5).map do |project|
          [
            project,
            total_spent_time(current_user, project),
            month_spent_time(current_user, project),
            last_month_spent_time(current_user, project)
          ]
        end
      options["model"][:projects] = 
        Kaminari.paginate_array(projects, total_count: Project.count)
        .page(params[:project_page] || 1)
        .per(5)
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

      SqlSpendedTimeCalculator.call(records)
    end

    def self.month_spent_time(current_user, project)
      records = RecordsMonthUserProjectQuery.call(
        user: current_user,
        project: project
      )

      SqlSpendedTimeCalculator.call(records)
    end

    def self.last_month_spent_time(current_user, project)
      records = RecordsMonthUserProjectQuery.call(
        user: current_user,
        project: project,
        month: 1.month.ago
      )

      SqlSpendedTimeCalculator.call(records)
    end
  end
end
