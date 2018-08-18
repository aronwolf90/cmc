# frozen_string_literal: true

module Administration
  module WikiCategories
    class CreateOperation < AdministrationOperation
      @form = WikiCategoryForm
      @policy = WikiCategoryPolicy
      include MvcStandardCreateOperationConcern
    end
  end
end
