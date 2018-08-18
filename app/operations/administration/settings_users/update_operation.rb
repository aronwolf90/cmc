# frozen_string_literal: true

module Administration
  module SettingsUsers
    class UpdateOperation < AdministrationOperation
      @form = SettingsUserForm
      @policy = UserPolicy
      include MvcStandardUpdateOperationConcern
    end
  end
end
