# frozen_string_literal: true

module Administration
  module Issues
    class CreateOperation < AdministrationOperation
      @model_step = ModelStep
      @form = IssueForm
      include MvcStandardCreateOperationConcern
    end
  end
end
