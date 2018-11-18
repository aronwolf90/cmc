# frozen_string_literal: true

module Administration::Dashboard
  class AssignedIssuesStep < BaseIssuesStep
    def self.call(options, current_user:, **args)
      super(options, :assigned, current_user.issues, **args)
    end
  end
end
