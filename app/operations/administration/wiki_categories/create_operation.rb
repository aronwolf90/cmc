# frozen_string_literal: true

module Administration
  module WikiCategories
    class CreateOperation < AdministrationOperation
      @form = WikiCategoryForm
      include MvcStandardCreateOperationConcern
    end
  end
end
