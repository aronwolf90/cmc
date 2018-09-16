# frozen_string_literal: true

module Administration
  class UsersController < AdministrationController
    side_menu "administration/users", only: %i[index new create]
    side_menu "administration/specific_user", only: %i[edit update]
    namespace Users

    public :index, :new, :edit

    def create
      super { %i[administration users] }
    end

    def update
      super do |model|
        edit_administration_user_path(model)
      end
    end

    def destroy
      super %i[administration users]
    end
  end
end
