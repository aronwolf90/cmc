# frozen_string_literal: true

module Administration::Dashboard
  class WorkedIssuesStep < BaseIssuesStep
    def self.call(options, current_user:, **args)
      super(options, :worked, current_user.worked_issues, **args)
    end
  end
end
