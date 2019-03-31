# frozen_string_literal: true

module Administration
  module Issues
    class CreateOperation < AdministrationOperation
      @form = IssueForm
      include MvcStandardCreateOperationConcern
    end
  end
end
