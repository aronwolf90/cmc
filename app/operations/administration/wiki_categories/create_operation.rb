# frozen_string_literal: true

module Administration
  module WikiCategories
    class CreateOperation < AdministrationOperation
      @form = WikiCategoryForm
      include StandardCreateOperationConcern
    end
  end
end
