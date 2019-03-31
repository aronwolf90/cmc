# frozen_string_literal: true

module Administration
  module WikiCategories
    class NewOperation < AdministrationOperation
      @form = WikiCategoryForm
      include MvcStandardNewOperationConcern
    end
  end
end
