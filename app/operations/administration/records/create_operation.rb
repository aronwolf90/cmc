# frozen_string_literal: true

module Administration
  module Records
    class CreateOperation < AdministrationOperation
      include MvcStandardCreateOperationConcern
    end
  end
end
