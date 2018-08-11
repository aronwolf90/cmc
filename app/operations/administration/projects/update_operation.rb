# frozen_string_literal: true

module Administration
  module Projects
    class UpdateOperation < AdministrationOperation
      @form = ProjectForm
      include MvcStandardUpdateOperationConcern
    end
  end
end
