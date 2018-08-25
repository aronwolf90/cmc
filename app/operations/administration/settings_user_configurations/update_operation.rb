# frozen_string_literal: true

module Administration
  module SettingsUserConfigurations
    class UpdateOperation < AdministrationOperation
      @form = SettingsUserConfigurationForm
      include MvcStandardUpdateOperationConcern
    end
  end
end
