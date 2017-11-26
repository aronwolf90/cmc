module Administration
  module UserSettings
    class UsersController < UserSettingsController
      def edit
        run User::Update::Present

        render cell(User::Cell::Edit, @form)
      end

      def update
        run User::Update do
          flash[:notice] = 'Successful update'
          return render cell(User::Cell::Edit, @form)
        end

        render cell(User::Cell::Edit, @form)
      end
    end
  end
end
