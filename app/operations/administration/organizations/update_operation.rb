# frozen_string_literal: true

module Administration
  module Organizations
    class UpdateOperation < AdministrationOperation
      @form = OrganizationForm
      @model_step = ModelStep
      @policy = OrganizationPolicy
      include MvcStandardUpdateOperationConcern
    end
  end
end
