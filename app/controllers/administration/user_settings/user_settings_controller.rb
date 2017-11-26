module Administration
  module UserSettings
    class UserSettingsController < AdministrationController
      private

      def set_side_menu
        @side_menu = 'administration/user_settings/shared/side_menu'
      end
    end
  end
end
