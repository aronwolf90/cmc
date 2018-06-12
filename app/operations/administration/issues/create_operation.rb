# frozen_string_literal: true

module Administration
  module Issues
    class CreateOperation < AdministrationOperation
      @form = IssueForm
      @default_value_step = SetDefaultValueStep
      include StandardCreateOperationConcern
    end
  end
end
