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
          [:edit, :administration, :settings, model]
        end
      end
    end
  end
end
