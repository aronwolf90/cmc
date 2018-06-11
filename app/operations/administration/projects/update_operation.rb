# frozen_string_literal: true

module Administration
  module Projects
    class UpdateOperation < AdministrationOperation
      @form = ProjectForm
      include StandardUpdateOperationConcern
    end
  end
end
