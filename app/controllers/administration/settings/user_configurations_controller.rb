# frozen_string_literal: true

module Administration
  module Settings
    class UserConfigurationsController < AdministrationController
      side_menu "administration/settings"
      namespace SettingsUserConfigurations

      def edit
        super
      end

      def update
        super do |model|
          edit_administration_settings_user_configuration_path(model)
        end
      end
    end
  end
end
