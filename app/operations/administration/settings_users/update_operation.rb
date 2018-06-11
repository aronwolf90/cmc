# frozen_string_literal: true

module Administration
  module SettingsUsers
    class UpdateOperation < AdministrationOperation
      @form = SettingsUserForm
      include StandardUpdateOperationConcern
    end
  end
end
