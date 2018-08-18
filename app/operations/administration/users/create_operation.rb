# frozen_string_literal: true

module Administration
  module Users
    class CreateOperation < AdministrationOperation
      @form = UserForm
      @policy = UserPolicy
      include MvcStandardCreateOperationConcern
    end
  end
end
