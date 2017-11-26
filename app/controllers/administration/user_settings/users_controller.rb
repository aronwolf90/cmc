module Administration
  module UserSettings
    class UsersController < UserSettingsController
      def show
        render inline: 'hi', layout: true
      end

      def edit
        render inline: 'hi', layout: true
      end
    end
  end
end
