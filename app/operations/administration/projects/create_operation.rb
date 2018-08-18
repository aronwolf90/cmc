# frozen_string_literal: true

module Administration
  module Projects
    class CreateOperation < AdministrationOperation
      @form = ProjectForm
      @policy = ProjectPolicy
      include MvcStandardCreateOperationConcern
    end
  end
end
