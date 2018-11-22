# frozen_string_literal: true

module Administration::Dashboard
  class ProjectsStep < ApplicationStep
    def self.call(options, current_user:, **)
      init(options)

      Project.find_each do |project|
        options["model"][:projects][project] = spent_time(current_user, project)
      end
    end

    def self.init(options)
      options["model"] ||= {}
      options["model"][:projects] ||= {}
    end

    def self.spent_time(current_user, project)
      SpendedTimeCalculator.call(records(current_user, project))
    end

    def self.records(current_user, project)
      RecordsUserProjectQuery.call(user: current_user, project: project)
    end
  end
end
