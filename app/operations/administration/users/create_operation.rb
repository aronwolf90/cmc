# frozen_string_literal: true

module Administration
  module Users
    class CreateOperation < AdministrationOperation
      @form = UserForm
      include MvcStandardCreateOperationConcern
    end
  end
end
