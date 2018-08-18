# frozen_string_literal: true

module Administration
  module Settings
    class UsersController < AdministrationController
      side_menu "administration/settings"
      namespace SettingsUsers

      def edit
        super
      end

      def update
        super do |model|
          edit_administration_settings_user_path(model)
        end
      end
    end
  end
end
