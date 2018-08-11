# frozen_string_literal: true

module Administration
  module WikiCategories
    class UpdateOperation < AdministrationOperation
      @form = WikiCategoryForm
      include MvcStandardUpdateOperationConcern
    end
  end
end
