# frozen_string_literal: true

module Administration
  module WikiCategories
    class UpdateOperation < AdministrationOperation
      @form = WikiCategoryForm
      @poliy = WikiCategoryPolicy
      include MvcStandardUpdateOperationConcern
    end
  end
end
