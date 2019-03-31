# frozen_string_literal: true

module Administration
  module Projects
    class CreateOperation < AdministrationOperation
      include MvcStandardCreateOperationConcern
    end
  end
end
