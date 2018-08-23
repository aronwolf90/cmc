# frozen_string_literal: true

module Administration
  module SettingsUsers
    class UpdateOperation < AdministrationOperation
      @form = SettingsUserForm
      include MvcStandardUpdateOperationConcern
    end
  end
end
