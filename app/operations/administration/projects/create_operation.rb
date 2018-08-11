# frozen_string_literal: true

module Administration
  module Projects
    class CreateOperation < AdministrationOperation
      @form = ProjectForm
      include MvcStandardCreateOperationConcern
    end
  end
end
