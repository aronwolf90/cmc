# frozen_string_literal: true

module Administration
  module Projects
    class UpdateOperation < AdministrationOperation
      @form = ProjectForm
      @policy = ProjectPolicy
      include MvcStandardUpdateOperationConcern
    end
  end
end
