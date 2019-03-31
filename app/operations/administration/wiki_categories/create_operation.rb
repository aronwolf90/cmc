# frozen_string_literal: true

module Administration
  module WikiCategories
    class CreateOperation < AdministrationOperation
      include MvcStandardCreateOperationConcern
    end
  end
end
