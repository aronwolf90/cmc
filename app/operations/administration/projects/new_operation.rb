# frozen_string_literal: true

module Administration
  module Projects
    class NewOperation < AdministrationOperation
      @form = ProjectForm
      include MvcStandardNewOperationConcern
    end
  end
end
