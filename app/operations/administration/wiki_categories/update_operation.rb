# frozen_string_literal: true

module Administration
  module WikiCategories
    class UpdateOperation < AdministrationOperation
      @form = WikiCategoryForm
      include StandardUpdateOperationConcern
    end
  end
end
