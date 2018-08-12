# frozen_string_literal: true

module Administration
  module Organizations
    class UpdateOperation < AdministrationOperation
      @form = OrganizationForm
      @model_step = ModelStep
      include MvcStandardUpdateOperationConcern
    end
  end
end
